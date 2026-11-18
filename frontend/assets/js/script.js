"use strict";

/**
 * Menú web de Final Fantasy IX.
 * La información de personajes, objetos, habilidades y armas se consulta
 * mediante el backend local y las tablas de backend/datos.sql.
 * El progreso de nivel, armas equipadas y habilidades pasivas activadas se
 * guarda en localStorage porque el dump original no contiene esas columnas.
 */
const API_BASE = "http://localhost:3000/api";
const STORAGE_KEY = "ff9-menu-progreso-v5";

const state = {
  personajes: [],
  modificadores: { hp: [], mp: [] },
  objetos: null,
  selectedId: 1,
  habilidades: null,
  equipo: {},
  popupType: null,
  skillTab: "pasivas",
  search: "",
  filter: "",
  weaponsExpanded: false,
  progress: loadProgress()
};

const $ = (selector, root = document) => root.querySelector(selector);
const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];

const ELEMENTS = {
  party: $("#listaParty"),
  partyCount: $("#contadorParty"),
  connection: $("#estadoConexion"),
  clock: $("#relojLocal"),
  gil: $("#gilAleatorio"),
  location: $("#localizacionTexto"),
  overlay: $("#popupOverlay"),
  popup: $("#popupPanel"),
  popupHeader: $(".popup-header"),
  popupToolbar: $(".popup-toolbar"),
  popupTitle: $("#popupTitle"),
  popupEyebrow: $("#popupEyebrow"),
  popupContext: $("#popupContext"),
  popupSearch: $("#popupSearch"),
  popupFilter: $("#popupFilter"),
  popupTabs: $("#popupTabs"),
  popupNotice: $("#popupNotice"),
  popupBody: $("#popupBody"),
  popupCount: $("#popupRecordCount"),
  popupFooter: $(".popup-footer"),
  toast: $("#levelToast")
};

function loadProgress() {
  try {
    const saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || "{}");
    return saved && typeof saved === "object" ? saved : {};
  } catch (error) {
    console.warn("No se pudo leer el progreso guardado; se iniciará desde nivel 1.", error);
    return {};
  }
}

function saveProgress() {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state.progress));
  } catch (error) {
    console.warn("No se pudo guardar el progreso local.", error);
    showToast("El navegador no permitió guardar el progreso.");
  }
}

function getProgress(characterId) {
  const key = String(characterId);
  if (!state.progress[key]) {
    state.progress[key] = {
      level: 1,
      bonus: { fuerza: 0, magia: 0, velocidad: 0, espiritu: 0, piedras: 0 },
      weaponId: null,
      passiveAbilities: []
    };
  }
  const progress = state.progress[key];
  progress.level = Math.max(1, Math.min(99, Number(progress.level) || 1));
  progress.bonus ||= {};
  for (const field of ["fuerza", "magia", "velocidad", "espiritu", "piedras"]) {
    progress.bonus[field] = Math.max(0, Number(progress.bonus[field]) || 0);
  }
  progress.passiveAbilities = Array.isArray(progress.passiveAbilities)
    ? progress.passiveAbilities.map(Number).filter(Number.isFinite)
    : [];
  progress.stonesUsed = Math.max(0, Number(progress.stonesUsed) || 0);
  return progress;
}

function escapeHtml(value) {
  return String(value ?? "").replace(/[&<>"']/g, (character) => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
  })[character]);
}

function formatNumber(value) {
  return Number(value || 0).toLocaleString("es-CL");
}

async function apiGet(path) {
  let response;
  try {
    response = await fetch(`${API_BASE}${path}`, { headers: { Accept: "application/json" } });
  } catch (error) {
    throw new Error("No se pudo contactar a http://localhost:3000. Inicia el backend con npm run dev.");
  }

  const contentType = response.headers.get("content-type") || "";
  const payload = contentType.includes("application/json")
    ? await response.json()
    : await response.text();

  if (!response.ok) {
    const message = payload && typeof payload === "object"
      ? (payload.mensaje || payload.message || `Error HTTP ${response.status}`)
      : (payload || `Error HTTP ${response.status}`);
    throw new Error(message);
  }
  if (typeof payload === "string") {
    throw new Error("El backend respondió texto en lugar de JSON. Comprueba que ejecutaste el server.js de esta versión.");
  }
  if (payload?.error) throw new Error(payload.mensaje || "Error consultando MySQL.");
  return payload;
}

function setConnection(connected, message) {
  ELEMENTS.connection.classList.remove("is-loading", "is-connected", "is-offline");
  ELEMENTS.connection.classList.add(connected ? "is-connected" : "is-offline");
  ELEMENTS.connection.textContent = message;
}

function magicStoneIcon(extraClass = "") {
  return `<span class="magic-stone-icon ${extraClass}" aria-hidden="true"><i></i></span>`;
}

function calculateStats(character, weapon = null) {
  const base = character.statsNivel1;
  const progress = getProgress(character.id);
  const level = progress.level;
  const bonus = progress.bonus;
  const hpMod = Number(state.modificadores.hp[level - 1] || state.modificadores.hp.at(-1) || 250);
  const mpMod = Number(state.modificadores.mp[level - 1] || state.modificadores.mp.at(-1) || 200);

  // La progresión se calcula con los modificadores cargados desde server.js.
  const fuerza = base.fuerza + Math.floor(level * 3 / 10) + Math.floor(bonus.fuerza / 32);
  const magia = base.magia + Math.floor(level * 3 / 10) + Math.floor(bonus.magia / 32);
  const velocidad = base.velocidad + Math.floor(level / 10) + Math.floor(bonus.velocidad / 32);
  const espiritu = base.espiritu + Math.floor(level * 3 / 20) + Math.floor(bonus.espiritu / 32);
  const piedras = base.piedras + Math.floor(level * 4 / 10) + Math.floor(bonus.piedras / 32);
  const hp = Math.floor(fuerza * hpMod / 50);
  const mp = Math.floor(magia * mpMod / 100);

  return {
    level, hp, mp, fuerza, magia, velocidad, espiritu, piedras,
    ataque: Number(weapon?.ataque || 0),
    defensaFisica: Number(weapon?.defensaFisica || 0),
    defensaMagica: Number(weapon?.defensaMagica || 0),
    evasionFisica: Number(weapon?.evasionFisica || 0),
    evasionMagica: Number(weapon?.evasionMagica || 0)
  };
}

function findCharacter(id = state.selectedId) {
  return state.personajes.find((character) => Number(character.id) === Number(id));
}

function getEquippedWeapon(characterId) {
  const progress = getProgress(characterId);
  const list = state.equipo?.[characterId] || [];
  return list.find((item) => Number(item.idEquipo) === Number(progress.weaponId)) || null;
}

function portraitSlug(name) {
  const map = {
    Zidane: "zidane", Steiner: "steiner", Vivi: "vivi", Garnet: "garnet", Dagger: "garnet",
    Freya: "freya", Quina: "quina", Eiko: "eiko", Amarant: "amarant"
  };
  return map[name] || String(name || "zidane").toLowerCase().replace(/[^a-z0-9]+/g, "");
}

function portraitSources(name) {
  const slug = portraitSlug(name);
  // Primero se intenta la carpeta de retratos ampliados; luego assets/img directamente.
  return [
    `assets/img/personajes/${slug}.jpg`,
    `assets/img/${slug}.jpg`,
    `assets/img/personajes/${slug}.png`,
    `assets/img/${slug}.png`,
    `assets/img/personajes/${slug}.jpeg`,
    `assets/img/${slug}.jpeg`,
    `assets/img/personajes/${slug}.webp`,
    `assets/img/${slug}.webp`
  ];
}

function portraitElement(name, className = "character-portrait") {
  const sources = portraitSources(name);
  return `<img class="${className}" src="${sources[0]}" data-fallbacks='${JSON.stringify(sources.slice(1))}' alt="Retrato de ${escapeHtml(name)}" loading="lazy">`;
}

function handlePortraitFallback(event) {
  const image = event.target;
  if (!(image instanceof HTMLImageElement) || !image.matches(".character-portrait, .game-character-portrait")) return;
  let fallbacks = [];
  try { fallbacks = JSON.parse(image.dataset.fallbacks || "[]"); } catch (error) { fallbacks = []; }
  const next = fallbacks.shift();
  image.dataset.fallbacks = JSON.stringify(fallbacks);
  if (next) image.src = next;
  else {
    image.onerror = null;
    image.classList.add("portrait-unavailable");
    image.alt = `Retrato no encontrado: ${image.alt.replace("Retrato de ", "")}`;
  }
}

function renderParty() {
  if (!state.personajes.length) return;
  ELEMENTS.partyCount.textContent = `${String(state.personajes.length).padStart(2, "0")} / 08`;
  ELEMENTS.party.innerHTML = state.personajes.map((character) => {
    const id = Number(character.id);
    const stats = calculateStats(character, getEquippedWeapon(id));
    const progress = getProgress(id);
    const selected = id === Number(state.selectedId);
    return `
      <button type="button" class="character-row${selected ? " is-selected" : ""}" data-character-id="${id}" aria-pressed="${selected}">
        ${portraitElement(character.nombre)}
        <span class="character-info">
          <span class="character-topline">
            <span class="character-name">${escapeHtml(character.nombre)}</span>
            <span class="character-level">Lv <strong>${stats.level}</strong></span>
          </span>
          <span class="character-resource-layout">
            <span class="character-resource-stack">
              <span>HP <b>${formatNumber(stats.hp)} / ${formatNumber(stats.hp)}</b></span>
              <span>MP <b>${formatNumber(stats.mp)} / ${formatNumber(stats.mp)}</b></span>
            </span>
            <span class="character-stones" title="Piedras mágicas equipadas / disponibles">${magicStoneIcon()}<b>${progress.stonesUsed} / ${stats.piedras}</b></span>
          </span>
        </span>
      </button>`;
  }).join("");
}

function selectCharacter(id) {
  if (!findCharacter(id)) return;
  state.selectedId = Number(id);
  renderParty();
}

function localClock() {
  const update = () => {
    ELEMENTS.clock.textContent = new Intl.DateTimeFormat(undefined, {
      hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false
    }).format(new Date());
  };
  update();
  window.setInterval(update, 1000);
}

function setRandomGil() {
  const gil = Math.floor(Math.random() * (100000 - 100 + 1)) + 100;
  ELEMENTS.gil.textContent = `${formatNumber(gil)} G`;
}

function showToast(message) {
  ELEMENTS.toast.textContent = message;
  ELEMENTS.toast.classList.add("is-visible");
  window.clearTimeout(showToast.timer);
  showToast.timer = window.setTimeout(() => ELEMENTS.toast.classList.remove("is-visible"), 2400);
}

function levelUpSelectedCharacter() {
  const character = findCharacter();
  if (!character) return;
  const progress = getProgress(character.id);
  if (progress.level >= 99) {
    showToast(`${character.nombre} ya alcanzó el nivel máximo.`);
    return;
  }

  const weapon = getEquippedWeapon(character.id);
  progress.bonus.fuerza += 3 + Number(weapon?.fuerza || 0);
  progress.bonus.magia += 3 + Number(weapon?.magia || 0);
  progress.bonus.velocidad += Number(weapon?.rapidez || 0);
  progress.bonus.espiritu += 1 + Number(weapon?.espiritu || 0);
  progress.bonus.piedras += 5;
  progress.level += 1;
  saveProgress();
  renderParty();
  showToast(`¡${character.nombre} subió al nivel ${progress.level}!`);
}

function setPopupNotice(message = "") {
  ELEMENTS.popupNotice.textContent = message;
  ELEMENTS.popupNotice.hidden = !message;
}

function openPopupShell(type) {
  const character = findCharacter();
  const titles = {
    items: ["Item", "INVENTARIO · ARCHIVO", "Catálogo de objetos guardado en la base inv_ff9"],
    abilities: ["Ability", "HABILIDADES · MEMORIA", `Habilidades registradas para ${character?.nombre || "el personaje"}`],
    equipment: ["Equip", "EQUIPO · MEMORIA", `Armas disponibles para ${character?.nombre || "el personaje"}`]
  };
  const [title, eyebrow, context] = titles[type];
  const gameLayout = type === "abilities" || type === "equipment";
  state.popupType = type;
  state.search = "";
  state.filter = "";
  state.weaponsExpanded = false;
  ELEMENTS.popup.className = `ff9-popup popup-mode-${type}`;
  ELEMENTS.popupTitle.textContent = title;
  ELEMENTS.popupEyebrow.textContent = eyebrow;
  ELEMENTS.popupContext.textContent = context;
  ELEMENTS.popupSearch.value = "";
  ELEMENTS.popupSearch.placeholder = "Buscar un objeto...";
  ELEMENTS.popupFilter.innerHTML = '<option value="">Todas las categorías</option>';
  ELEMENTS.popupHeader.hidden = gameLayout;
  ELEMENTS.popupToolbar.hidden = gameLayout;
  ELEMENTS.popupTabs.hidden = true;
  ELEMENTS.popupNotice.hidden = gameLayout;
  ELEMENTS.popupFooter.hidden = gameLayout;
  ELEMENTS.popupBody.classList.toggle("game-screen-body", gameLayout);
  ELEMENTS.popupBody.innerHTML = '<div class="popup-loading">Consultando los registros de MySQL...</div>';
  ELEMENTS.popupCount.textContent = "CARGANDO";
  setPopupNotice("");
  ELEMENTS.overlay.hidden = false;
  document.body.classList.add("popup-open");
  if (!gameLayout) $("#cerrarPopup").focus();
}

function closePopup() {
  ELEMENTS.overlay.hidden = true;
  document.body.classList.remove("popup-open");
  state.popupType = null;
  state.search = "";
  state.filter = "";
  ELEMENTS.popup.className = "ff9-popup";
  ELEMENTS.popupHeader.hidden = false;
  ELEMENTS.popupToolbar.hidden = false;
  ELEMENTS.popupNotice.hidden = false;
  ELEMENTS.popupFooter.hidden = false;
  ELEMENTS.popupBody.classList.remove("game-screen-body");
  $$(".ff9-command").forEach((button) => button.classList.toggle("is-active", button.dataset.menu === "items"));
}

async function openMenu(type) {
  const button = $(`[data-menu="${type}"]`);
  $$(".ff9-command[data-menu]").forEach((item) => item.classList.toggle("is-active", item === button));
  openPopupShell(type);

  try {
    if (type === "items") {
      if (!state.objetos) state.objetos = await apiGet("/objetos");
      renderItems();
      return;
    }
    if (type === "abilities") {
      state.skillTab = "pasivas";
      state.habilidades = await apiGet(`/personajes/${state.selectedId}/habilidades`);
      levelUpSelectedCharacter();
      renderAbilities();
      return;
    }
    if (type === "equipment") {
      const items = await apiGet(`/personajes/${state.selectedId}/equipo`);
      state.equipo[state.selectedId] = items;
      const progress = getProgress(state.selectedId);
      if (!items.some((item) => Number(item.idEquipo) === Number(progress.weaponId))) {
        progress.weaponId = items[0]?.idEquipo ?? null;
      }
      saveProgress();
      levelUpSelectedCharacter();
      renderEquipment();
      return;
    }
  } catch (error) {
    ELEMENTS.popupBody.innerHTML = `<div class="empty-state">${escapeHtml(error.message)}<br><br>Revisa la terminal del backend y la configuración de MySQL.</div>`;
    ELEMENTS.popupCount.textContent = "ERROR DE CONSULTA";
    setPopupNotice("No se mostraron datos de ejemplo: se está mostrando el error real de la consulta.");
  }
}

function renderItems() {
  const items = Array.isArray(state.objetos) ? state.objetos : [];
  const categories = [...new Set(items.map((item) => item.tipo).filter(Boolean))].sort((a, b) => a.localeCompare(b));
  ELEMENTS.popupFilter.innerHTML = '<option value="">Todas las categorías</option>' + categories.map((category) =>
    `<option value="${escapeHtml(category)}">${escapeHtml(category)}</option>`
  ).join("");
  if (state.filter) ELEMENTS.popupFilter.value = state.filter;

  const query = state.search.trim().toLocaleLowerCase("es");
  const filtered = items.filter((item) => {
    const matchQuery = !query || `${item.nombre} ${item.descripcion}`.toLocaleLowerCase("es").includes(query);
    const matchType = !state.filter || item.tipo === state.filter;
    return matchQuery && matchType;
  });

  ELEMENTS.popupBody.innerHTML = filtered.length ? `
    <table class="table ff9-table align-middle">
      <thead><tr><th>ID</th><th>OBJETO</th><th>TIPO</th><th>DESCRIPCIÓN</th></tr></thead>
      <tbody>${filtered.map((item) => `
        <tr><td class="table-id">${item.id}</td><td class="table-name">${escapeHtml(item.nombre)}</td>
        <td class="table-category">${escapeHtml(item.tipo)}</td><td class="table-description">${escapeHtml(item.descripcion)}</td></tr>
      `).join("")}</tbody>
    </table>` : '<div class="empty-state">No hay objetos que coincidan con la búsqueda.</div>';
  ELEMENTS.popupCount.textContent = `${filtered.length} / ${items.length} OBJETOS`;
  setPopupNotice("El SQL contiene el catálogo de objetos; no tiene una tabla de cantidades por objeto.");
}

function getPassiveStoneUsage(abilities, progress) {
  const byId = new Map((abilities || []).map((ability) => [Number(ability.id), ability]));
  return progress.passiveAbilities.reduce((total, id) => total + Number(byId.get(Number(id))?.costePiedras || 0), 0);
}

function renderGameTitle(title) {
  return `<div class="game-menu-title"><span>${title}</span><button type="button" data-popup-close aria-label="Cerrar menú">✕</button></div>`;
}

function renderGameCharacterHeader(character, stats, rightContent) {
  const image = portraitElement(character.nombre, "game-character-portrait");
  return `
    <div class="game-character-strip">
      <section class="game-player-box">
        <div class="game-box-label">PLAYER</div>
        ${image}
        <div class="game-player-details">
          <div class="game-player-title"><strong>${escapeHtml(character.nombre)}</strong><b>Lv ${stats.level}</b></div>
          <div class="game-player-resource">HP <strong>${formatNumber(stats.hp)} / ${formatNumber(stats.hp)}</strong></div>
          <div class="game-player-resource">MP <strong>${formatNumber(stats.mp)} / ${formatNumber(stats.mp)}</strong></div>
        </div>
      </section>
      <section class="game-side-info">
        <div class="game-box-label">INFO</div>
        ${rightContent}
      </section>
    </div>`;
}

function renderAbilityEntry(ability, tab, progress) {
  const passive = tab === "pasivas";
  const equipped = passive && progress.passiveAbilities.includes(Number(ability.id));
  const title = escapeHtml(ability.descripcion || ability.nombre);
  const costMarkup = passive
    ? `<span class="ability-cost-item">PH ${formatNumber(ability.costePH)}</span><span class="ability-cost-item">${magicStoneIcon()} ${formatNumber(ability.costePiedras)}</span>`
    : `<span class="ability-cost-item">PH ${formatNumber(ability.costePH)}</span><span class="ability-cost-item">MP ${formatNumber(ability.costePM)}</span>`;
  const marker = passive
    ? `<span class="ability-slot-mark${equipped ? " is-equipped" : ""}" aria-hidden="true">${equipped ? magicStoneIcon() : ""}</span>`
    : `<span class="ability-slot-mark" aria-hidden="true"></span>`;
  const classes = `ability-game-row${equipped ? " is-equipped" : ""}`;
  if (passive) {
    return `<button type="button" class="${classes}" data-toggle-passive="${Number(ability.id)}" aria-pressed="${equipped}" title="${title}">
      ${marker}<span class="ability-game-name">${escapeHtml(ability.nombre)}</span><span class="ability-game-cost">${costMarkup}</span>
    </button>`;
  }
  return `<div class="${classes}" title="${title}">${marker}<span class="ability-game-name">${escapeHtml(ability.nombre)}</span><span class="ability-game-cost">${costMarkup}</span></div>`;
}

function renderAbilities() {
  const character = findCharacter();
  if (!character) return;
  const data = state.habilidades || { activas: [], pasivas: [] };
  const progress = getProgress(character.id);
  const weapon = getEquippedWeapon(character.id);
  const stats = calculateStats(character, weapon);
  const current = state.skillTab === "pasivas" ? data.pasivas : data.activas;
  const query = state.search.trim().toLocaleLowerCase("es");
  const filtered = current.filter((ability) => `${ability.nombre} ${ability.descripcion}`.toLocaleLowerCase("es").includes(query));
  const usedStones = getPassiveStoneUsage(data.pasivas, progress);
  progress.stonesUsed = usedStones;
  saveProgress();
  // La lista se presenta como una única tabla desplazable: cada fila contiene
  // una habilidad a la izquierda y otra a la derecha, igual que en el menú original.
  const skillCostHeading = state.skillTab === "pasivas" ? "PH / PIEDRAS" : "PH / MP";
  const pairedRows = [];
  for (let index = 0; index < filtered.length; index += 2) {
    const leftAbility = filtered[index];
    const rightAbility = filtered[index + 1];
    pairedRows.push(`
      <div class="ability-game-pair">
        ${renderAbilityEntry(leftAbility, state.skillTab, progress)}
        ${rightAbility
          ? renderAbilityEntry(rightAbility, state.skillTab, progress)
          : '<div class="ability-game-cell-empty" aria-hidden="true"></div>'}
      </div>`);
  }
  const abilityTable = `
    <div class="ability-game-grid" role="list" aria-label="Lista de habilidades">
      <div class="ability-game-head-row" aria-hidden="true">
        <div class="ability-game-column-head"><span>ABILITY</span><span>${skillCostHeading}</span></div>
        <div class="ability-game-column-head"><span>ABILITY</span><span>${skillCostHeading}</span></div>
      </div>
      ${pairedRows.join("") || '<div class="ability-empty-cell">No hay habilidades para mostrar.</div>'}
    </div>`;

  ELEMENTS.popupBody.innerHTML = `
    <div class="game-ability-layout">
      ${renderGameTitle("Ability")}
      ${renderGameCharacterHeader(character, stats, `
        <div class="ability-magic-counter"><span>PIEDRAS MÁGICAS</span><strong>${magicStoneIcon()} ${usedStones} / ${stats.piedras}</strong></div>
        <div class="ability-summary-line"><span>Activas</span><b>${data.activas.length}</b></div>
        <div class="ability-summary-line"><span>Pasivas</span><b>${data.pasivas.length}</b></div>
      `)}
      <div class="ability-tab-bar" role="tablist" aria-label="Tipo de habilidad">
        <button type="button" role="tab" aria-selected="${state.skillTab === "activas"}" class="ability-tab${state.skillTab === "activas" ? " is-current" : ""}" data-skill-tab="activas">HABILIDADES ACTIVAS</button>
        <button type="button" role="tab" aria-selected="${state.skillTab === "pasivas"}" class="ability-tab${state.skillTab === "pasivas" ? " is-current" : ""}" data-skill-tab="pasivas">HABILIDADES PASIVAS</button>
      </div>
      ${abilityTable}
      <div class="game-bottom-bar">
        <span>${state.skillTab === "pasivas" ? "SELECCIONA UNA HABILIDAD PARA EQUIPARLA O QUITARLA" : "HABILIDADES DISPONIBLES PARA EL PERSONAJE"}</span>
        <strong>${filtered.length} / ${current.length}</strong>
      </div>
    </div>`;
  ELEMENTS.popupCount.textContent = `${filtered.length} / ${current.length} HABILIDADES`;
}

function statLine(label, value) {
  return `<div class="equip-stat-line"><span>${label}</span><strong>${formatNumber(value)}</strong></div>`;
}

function renderEquipment() {
  const character = findCharacter();
  if (!character) return;
  const items = state.equipo?.[state.selectedId] || [];
  const progress = getProgress(state.selectedId);
  const weapon = getEquippedWeapon(state.selectedId);
  const stats = calculateStats(character, weapon);
  const query = state.search.trim().toLocaleLowerCase("es");
  const filtered = items.filter((item) => `${item.nombre} ${item.descripcion}`.toLocaleLowerCase("es").includes(query));
  const weaponChoices = state.weaponsExpanded ? `
    <div class="weapon-choice-list">
      ${filtered.map((item) => `
        <button type="button" class="weapon-choice${Number(item.idEquipo) === Number(progress.weaponId) ? " is-current" : ""}" data-equip-id="${Number(item.idEquipo)}">
          <span class="weapon-choice-name">${escapeHtml(item.nombre)}</span>
          <span class="weapon-choice-stats">ATQ ${formatNumber(item.ataque)} · DEF ${formatNumber(item.defensaFisica)}</span>
          ${Number(item.idEquipo) === Number(progress.weaponId) ? '<b class="weapon-choice-check">✓</b>' : ""}
        </button>`).join("") || '<div class="weapon-empty">No hay armas para este personaje en equipo_por_personaje.</div>'}
    </div>` : "";
  const activeSkills = weapon?.habilidadesActivas || [];
  const passiveSkills = weapon?.habilidadesPasivas || [];
  const skillGroup = (heading, list) => `
    <section class="weapon-skill-group"><h3>${heading}</h3>
      ${list.length ? `<ul>${list.map((skill) => `<li>${escapeHtml(skill.nombre)}</li>`).join("")}</ul>` : '<p class="no-weapon-skills">Sin habilidades asociadas</p>'}
    </section>`;

  ELEMENTS.popupBody.innerHTML = `
    <div class="game-equipment-layout">
      ${renderGameTitle("Equip")}
      <div class="equipment-game-columns">
        <section class="equipment-status-panel">
          <div class="game-box-label">INFO</div>
          <div class="equipment-character-card">
            ${portraitElement(character.nombre, "game-character-portrait")}
            <div class="equipment-character-summary">
              <div class="equipment-character-name">${escapeHtml(character.nombre)} <strong>Lv ${stats.level}</strong></div>
              <div>HP <b>${formatNumber(stats.hp)} / ${formatNumber(stats.hp)}</b></div>
              <div>MP <b>${formatNumber(stats.mp)} / ${formatNumber(stats.mp)}</b></div>
              <div class="equipment-stones">${magicStoneIcon()} <b>${stats.piedras}</b></div>
            </div>
          </div>
          <div class="equipment-stat-divider"></div>
          <div class="equipment-stat-list">
            ${statLine("Speed", stats.velocidad)}
            ${statLine("Strength", stats.fuerza)}
            ${statLine("Magic", stats.magia)}
            ${statLine("Spirit", stats.espiritu)}
            <div class="equipment-stat-spacer"></div>
            ${statLine("Attack", stats.ataque)}
            ${statLine("Defence", stats.defensaFisica)}
            ${statLine("Evade", stats.evasionFisica)}
            ${statLine("Magic Def", stats.defensaMagica)}
            ${statLine("Magic Eva", stats.evasionMagica)}
          </div>
        </section>

        <section class="equipment-game-right">
          <div class="equipment-list-panel">
            <div class="game-box-label">EQUIPMENT</div>
            <button type="button" class="equipment-slot-button" data-toggle-weapons aria-expanded="${state.weaponsExpanded}">
              <span class="equipment-slot-icon" aria-hidden="true">⚔</span>
              <span class="equipment-slot-type">Weapon</span><span class="equipment-slot-separator">:</span>
              <strong>${escapeHtml(weapon?.nombre || "None")}</strong><span class="equipment-slot-arrow">${state.weaponsExpanded ? "▲" : "▼"}</span>
            </button>
            ${weaponChoices}
            <div class="equipment-selected-description">${escapeHtml(weapon?.descripcion || "Selecciona un arma disponible para este personaje.")}</div>
          </div>

          <div class="equipment-ability-panel">
            <div class="game-box-label">ABILITY</div>
            <div class="equipment-weapon-ability-summary">
              ${weapon ? `<span>Habilidades de <strong>${escapeHtml(weapon.nombre)}</strong></span>` : "Selecciona un arma para consultar sus habilidades."}
            </div>
            <div class="weapon-skill-columns">
              ${skillGroup("ACTIVAS", activeSkills)}
              ${skillGroup("PASIVAS", passiveSkills)}
            </div>
          </div>
        </section>
      </div>
      <div class="game-bottom-bar equipment-bottom-bar">
        <button type="button" data-optimize-weapon ${items.length ? "" : "disabled"}>OPTIMISE</button>
        <button type="button" data-unequip-weapon ${weapon ? "" : "disabled"}>OFF</button>
        <span><kbd>ESC</kbd> VOLVER</span>
      </div>
    </div>`;
  ELEMENTS.popupCount.textContent = `${items.length} ARMAS DISPONIBLES`;
}

function handleSearch() {
  state.search = ELEMENTS.popupSearch.value || "";
  switch (state.popupType) {
    case "items": renderItems(); break;
    case "equipment": renderEquipment(); break;
    default: break;
  }
}

function handleFilter() {
  state.filter = ELEMENTS.popupFilter.value || "";
  if (state.popupType === "items") renderItems();
}

function handlePartyClick(event) {
  const button = event.target.closest("[data-character-id]");
  if (button) selectCharacter(Number(button.dataset.characterId));
}

function handleCommandClick(event) {
  const button = event.target.closest("[data-menu]");
  if (button && !button.disabled) openMenu(button.dataset.menu);
}

function handlePopupClick(event) {
  if (event.target === ELEMENTS.overlay || event.target.closest("#cerrarPopup, [data-popup-close]")) {
    closePopup();
    return;
  }

  const tab = event.target.closest("[data-skill-tab]");
  if (tab) {
    state.skillTab = tab.dataset.skillTab;
    renderAbilities();
    return;
  }

  const passiveToggle = event.target.closest("[data-toggle-passive]");
  if (passiveToggle) {
    const character = findCharacter();
    const progress = getProgress(state.selectedId);
    const abilityId = Number(passiveToggle.dataset.togglePassive);
    const ability = (state.habilidades?.pasivas || []).find((item) => Number(item.id) === abilityId);
    if (!ability) return;
    const index = progress.passiveAbilities.indexOf(abilityId);
    if (index >= 0) {
      progress.passiveAbilities.splice(index, 1);
    } else {
      const used = getPassiveStoneUsage(state.habilidades.pasivas, progress);
      const required = Number(ability.costePiedras || 0);
      const capacity = calculateStats(character).piedras;
      if (used + required > capacity) {
        showToast(`No hay piedras mágicas suficientes (${used} / ${capacity}).`);
        return;
      }
      progress.passiveAbilities.push(abilityId);
    }
    progress.stonesUsed = getPassiveStoneUsage(state.habilidades.pasivas, progress);
    saveProgress();
    renderAbilities();
    const usage = progress.stonesUsed;
    showToast(index >= 0 ? `${ability.nombre} desactivada.` : `${ability.nombre} equipada · ${usage} piedras mágicas.`);
    return;
  }

  if (event.target.closest("[data-toggle-weapons]")) {
    state.weaponsExpanded = !state.weaponsExpanded;
    renderEquipment();
    return;
  }

  const equipButton = event.target.closest("[data-equip-id]");
  if (equipButton) {
    const progress = getProgress(state.selectedId);
    progress.weaponId = Number(equipButton.dataset.equipId);
    state.weaponsExpanded = false;
    saveProgress();
    renderParty();
    renderEquipment();
    showToast(`${getEquippedWeapon(state.selectedId)?.nombre || "Arma"} equipada para ${findCharacter()?.nombre}.`);
    return;
  }

  if (event.target.closest("[data-optimize-weapon]")) {
    const weapons = state.equipo?.[state.selectedId] || [];
    const best = [...weapons].sort((a, b) =>
      (Number(b.ataque) + Number(b.defensaFisica) + Number(b.defensaMagica)) -
      (Number(a.ataque) + Number(a.defensaFisica) + Number(a.defensaMagica))
    )[0];
    if (best) {
      getProgress(state.selectedId).weaponId = Number(best.idEquipo);
      saveProgress();
      renderParty();
      renderEquipment();
      showToast(`${best.nombre} equipada automáticamente.`);
    }
    return;
  }

  if (event.target.closest("[data-unequip-weapon]")) {
    getProgress(state.selectedId).weaponId = null;
    saveProgress();
    renderParty();
    renderEquipment();
    showToast(`Arma retirada de ${findCharacter()?.nombre}.`);
  }
}

async function initialise() {
  localClock();
  setRandomGil();
  if (ELEMENTS.location) ELEMENTS.location.textContent = "Memoria / Time Warp";

  ELEMENTS.party.addEventListener("click", handlePartyClick);
  ELEMENTS.party.addEventListener("error", handlePortraitFallback, true);
  $$(".command-list")[0]?.addEventListener("click", handleCommandClick);
  ELEMENTS.overlay.addEventListener("click", handlePopupClick);
  ELEMENTS.overlay.addEventListener("error", handlePortraitFallback, true);
  ELEMENTS.popupSearch.addEventListener("input", handleSearch);
  ELEMENTS.popupFilter.addEventListener("change", handleFilter);
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && !ELEMENTS.overlay.hidden) closePopup();
  });

  try {
    const payload = await apiGet("/personajes");
    state.personajes = Array.isArray(payload.personajes) ? payload.personajes : [];
    state.modificadores = payload.modificadoresNivel || state.modificadores;
    if (!state.personajes.length) throw new Error("La tabla personaje no devolvió registros.");

    state.selectedId = state.personajes.some((item) => Number(item.id) === 1) ? 1 : Number(state.personajes[0].id);
    state.personajes.forEach((character) => getProgress(character.id));

    // Precarga la relación personaje-arma del SQL. No se inventan armas ni habilidades.
    await Promise.all(state.personajes.map(async (character) => {
      const id = Number(character.id);
      try {
        const weapons = await apiGet(`/personajes/${id}/equipo`);
        state.equipo[id] = weapons;
        const progress = getProgress(id);
        if (!weapons.some((item) => Number(item.idEquipo) === Number(progress.weaponId))) {
          progress.weaponId = weapons[0]?.idEquipo ?? null;
        }
      } catch (equipmentError) {
        state.equipo[id] = [];
        console.error(`No se pudieron precargar las armas de ${character.nombre}:`, equipmentError.message);
      }
    }));

    saveProgress();
    renderParty();
    setConnection(true, "MYSQL CONECTADO · inv_ff9");
  } catch (error) {
    setConnection(false, "MYSQL SIN CONEXIÓN");
    ELEMENTS.party.innerHTML = `<div class="party-message">${escapeHtml(error.message)}<br><br>Revisa que MySQL esté iniciado y que backend/.env apunte a inv_ff9.</div>`;
    ELEMENTS.partyCount.textContent = "-- / 08";
  }
}

document.addEventListener("DOMContentLoaded", initialise);
