const path = require("path");
require("dotenv").config({ path: path.join(__dirname, ".env") });

const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
const PORT = Number(process.env.PORT || 3000);
const DATABASE = process.env.DB_DATABASE || "inv_ff9";

// En el dump SQL no existe una tabla con estadísticas de nivel 1 ni con la
// progresión de nivel. Estos valores base proceden de las tablas de estado
// originales de Final Fantasy IX. El resto del catálogo se consulta en MySQL.
const STATS_NIVEL_1 = {
  1: { hp: 105, mp: 36, velocidad: 23, fuerza: 21, magia: 18, espiritu: 23, piedras: 18 }, // Zidane
  2: { hp: 120, mp: 24, velocidad: 18, fuerza: 24, magia: 12, espiritu: 21, piedras: 17 }, // Steiner
  3: { hp: 60, mp: 48, velocidad: 16, fuerza: 12, magia: 24, espiritu: 19, piedras: 14 }, // Vivi
  4: { hp: 70, mp: 46, velocidad: 21, fuerza: 14, magia: 23, espiritu: 17, piedras: 14 }, // Garnet
  5: { hp: 100, mp: 32, velocidad: 20, fuerza: 20, magia: 16, espiritu: 22, piedras: 18 }, // Freya
  6: { hp: 90, mp: 40, velocidad: 14, fuerza: 18, magia: 20, espiritu: 11, piedras: 15 }, // Quina
  7: { hp: 65, mp: 42, velocidad: 19, fuerza: 13, magia: 21, espiritu: 18, piedras: 12 }, // Eiko
  8: { hp: 110, mp: 26, velocidad: 22, fuerza: 22, magia: 13, espiritu: 15, piedras: 18 }  // Amarant
};

// Modificadores originales por nivel: HP = floor(Fuerza * HPMod / 50)
// y MP = floor(Magia * MPMod / 100). Índice 0 corresponde a nivel 1.
const HP_MOD = [
  250, 314, 382, 454, 530, 610, 694, 782, 874, 970,
  1062, 1150, 1234, 1313, 1390, 1462, 1530, 1594, 1662, 1734,
  1810, 1890, 1974, 2062, 2154, 2250, 2350, 2454, 2562, 2674,
  2790, 2910, 3034, 3162, 3282, 3394, 3498, 3594, 3682, 3762,
  3834, 3898, 3958, 4014, 4066, 4114, 4158, 4198, 4234, 4266,
  4294, 4317, 4334, 4344, 4353, 4361, 4368, 4374, 4379, 4383,
  4386, 4388, 4389, 4390, 4391, 4392, 4393, 4394, 4395, 4396,
  4397, 4398, 4399, 4400, 4401, 4402, 4403, 4404, 4405, 4406,
  4407, 4408, 4409, 4410, 4411, 4412, 4413, 4414, 4415, 4416,
  4417, 4418, 4419, 4420, 4421, 4422, 4423, 4424, 4524
];

const MP_MOD = [
  200, 206, 212, 219, 226, 234, 242, 250, 259, 268,
  277, 285, 293, 301, 308, 315, 321, 327, 333, 340,
  347, 355, 363, 371, 380, 389, 399, 409, 419, 430,
  441, 453, 465, 477, 489, 500, 510, 519, 527, 535,
  542, 548, 554, 559, 564, 568, 572, 576, 579, 582,
  584, 586, 587, 588, 589, 590, 591, 592, 593, 594,
  595, 596, 597, 598, 599, 600, 601, 602, 603, 604,
  605, 606, 607, 608, 609, 610, 611, 612, 613, 614,
  615, 616, 617, 618, 619, 620, 621, 622, 623, 624,
  625, 626, 627, 628, 629, 630, 631, 632, 642
];

// Orden del menú principal: Zidane, Garnet, Vivi, Steiner, Freya, Quina, Eiko y Amarant.
const ORDEN_MENU = [1, 4, 3, 2, 5, 6, 7, 8];
const ORIGENES_PERMITIDOS = [
  process.env.FRONTEND_URL,
  "http://127.0.0.1:5500",
  "http://localhost:5500",
  "http://127.0.0.1:5501",
  "http://localhost:5501"
].filter(Boolean);

app.use(cors({
  origin(origen, callback) {
    if (!origen || ORIGENES_PERMITIDOS.includes(origen)) return callback(null, true);
    return callback(new Error("Origen no permitido por CORS"));
  }
}));
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  charset: "utf8mb4"
});

function mensajeErrorMySQL(error) {
  const mensajes = {
    ECONNREFUSED: "MySQL Server no está iniciado o el puerto configurado no coincide.",
    ETIMEDOUT: "La conexión con MySQL agotó el tiempo de espera. Revisa DB_HOST y DB_PORT.",
    ER_ACCESS_DENIED_ERROR: "MySQL rechazó el usuario o la contraseña. Revisa backend/.env.",
    ER_BAD_DB_ERROR: `No existe la base ${DATABASE}. Revisa DB_DATABASE en backend/.env.`,
    ER_NO_SUCH_TABLE: "Falta una tabla del dump datos.sql en la base inv_ff9.",
    ER_BAD_FIELD_ERROR: "Una columna no coincide con datos.sql. Comprueba que usas el dump original de FF9."
  };
  return mensajes[error.code] || "No se pudo completar la consulta MySQL. Revisa el error de la terminal del backend.";
}

function responderError(res, error, contexto) {
  console.error(`[${contexto}] ${error.code || "ERROR"}: ${error.message}`);
  const status = error.code === "ER_ACCESS_DENIED_ERROR" || error.code === "ER_BAD_DB_ERROR" ? 503 : 500;
  return res.status(status).json({
    error: true,
    contexto,
    codigo: error.code || "ERROR_MYSQL",
    mensaje: mensajeErrorMySQL(error)
  });
}

function validarIdPersonaje(req, res, next) {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id < 1 || id > 8) {
    return res.status(400).json({ error: true, mensaje: "El ID del personaje debe estar entre 1 y 8." });
  }
  req.personajeId = id;
  next();
}

// Ruta raíz sencilla. No depende de un servicio externo ni de una API health.
app.get("/", (req, res) => {
  res.type("text/plain").send("Backend de Final Fantasy IX (MySQL) funcionando.");
});

// Personajes y sus valores iniciales del juego. Pj_Vit_Max / Pj_PM_Max /
// Pj_PieMag_Max se conservan como referencia SQL, no como nivel 1: en el dump
// no representan de forma consistente las estadísticas originales de nivel 1.
app.get("/api/personajes", async (req, res) => {
  try {
    const [filas] = await pool.query(`
      SELECT
        Pj_ID AS id,
        Pj_Nombre AS nombre,
        Pj_Vit_Max AS vitMaxSql,
        Pj_PM_Max AS pmMaxSql,
        Pj_PieMag_Max AS piedrasMaxSql
      FROM personaje
      ORDER BY FIELD(Pj_ID, ${ORDEN_MENU.join(", ")});
    `);

    const personajes = filas.map((fila) => ({
      ...fila,
      statsNivel1: STATS_NIVEL_1[Number(fila.id)]
    }));

    res.json({
      personajes,
      modificadoresNivel: { hp: HP_MOD, mp: MP_MOD }
    });
  } catch (error) {
    return responderError(res, error, "cargar personajes");
  }
});

// Catálogo real de objetos: son los 274 registros de la tabla objeto.
app.get("/api/objetos", async (req, res) => {
  try {
    const [filas] = await pool.query(`
      SELECT
        o.Objeto_ID AS id,
        o.Objeto_Nombre AS nombre,
        o.\`Objeto_Descripción\` AS descripcion,
        COALESCE(t.Tipo_Nombre, 'Sin categoría') AS tipo
      FROM objeto AS o
      LEFT JOIN tipo AS t ON t.Tipo_ID = o.Objeto_Tipo_ID
      ORDER BY o.Objeto_ID ASC;
    `);
    res.json(filas);
  } catch (error) {
    return responderError(res, error, "cargar objetos");
  }
});

// Habilidades que el SQL relaciona directamente con el personaje.
app.get("/api/personajes/:id/habilidades", validarIdPersonaje, async (req, res) => {
  try {
    const id = req.personajeId;
    const [activas] = await pool.query(`
      SELECT DISTINCT
        h.Hab_ID AS id,
        h.Hab_Nombre AS nombre,
        h.\`Hab_Descripción\` AS descripcion,
        h.Hab_Coste_PH AS costePH,
        h.Hab_Coste_PM AS costePM,
        h.Hab_Poder AS poder
      FROM activa_pj AS ap
      INNER JOIN habilidad_activa AS h ON h.Hab_ID = ap.Hab_Act_ID
      WHERE ap.Pj_ID = ? AND h.Hab_ID <> 0
      ORDER BY h.Hab_Nombre ASC;
    `, [id]);

    const [pasivas] = await pool.query(`
      SELECT DISTINCT
        h.Hab_ID AS id,
        h.Hab_Nombre AS nombre,
        h.\`Hab_Descripción\` AS descripcion,
        h.Hab_Coste_PH AS costePH,
        h.Hab_Coste_PieMag AS costePiedras
      FROM pasiva_pj AS pp
      INNER JOIN habilidad_pasiva AS h ON h.Hab_ID = pp.Hab_Pas_ID
      WHERE pp.Pj_ID = ? AND h.Hab_ID <> 0
      ORDER BY h.Hab_Nombre ASC;
    `, [id]);

    res.json({ activas, pasivas });
  } catch (error) {
    return responderError(res, error, `habilidades del personaje ${req.personajeId}`);
  }
});

// Armas permitidas al personaje según equipo_por_personaje. Las bonificaciones
// salen de equipo -> atributo; no se inventan valores fuera del dump SQL.
app.get("/api/personajes/:id/equipo", validarIdPersonaje, async (req, res) => {
  try {
    const id = req.personajeId;
    const [armas] = await pool.query(`
      SELECT
        e.Equipo_ID AS idEquipo,
        o.Objeto_ID AS id,
        o.Objeto_Nombre AS nombre,
        o.\`Objeto_Descripción\` AS descripcion,
        t.Tipo_Nombre AS tipo,
        COALESCE(a.Atr_Ata, 0) AS ataque,
        COALESCE(a.\`Atr_Def_Fís\`, 0) AS defensaFisica,
        COALESCE(a.\`Atr_Def_Mág\`, 0) AS defensaMagica,
        COALESCE(a.\`Atr_Eva_Fís\`, 0) AS evasionFisica,
        COALESCE(a.\`Atr_Eva_Mág\`, 0) AS evasionMagica,
        COALESCE(a.Atr_Rap, 0) AS rapidez,
        COALESCE(a.Atr_Fue, 0) AS fuerza,
        COALESCE(a.Atr_Mag, 0) AS magia,
        COALESCE(a.Atr_Esp, 0) AS espiritu
      FROM equipo_por_personaje AS ep
      INNER JOIN equipo AS e ON e.Equipo_ID = ep.Equipo_ID
      INNER JOIN objeto AS o ON o.Objeto_ID = e.Equipo_Obj_ID
      INNER JOIN tipo AS t ON t.Tipo_ID = o.Objeto_Tipo_ID
      LEFT JOIN atributo AS a ON a.Atr_ID = e.Equipo_Atr_ID
      WHERE ep.Pj_ID = ? AND o.Objeto_Tipo_ID = 2
      ORDER BY o.Objeto_ID ASC;
    `, [id]);

    const [activas] = await pool.query(`
      SELECT DISTINCT
        eha.Equipo_ID AS idEquipo,
        h.Hab_ID AS id,
        h.Hab_Nombre AS nombre
      FROM equipo_por_personaje AS ep
      INNER JOIN equipo_habilidad_activa AS eha ON eha.Equipo_ID = ep.Equipo_ID
      INNER JOIN habilidad_activa AS h ON h.Hab_ID = eha.Hab_Act_ID
      WHERE ep.Pj_ID = ? AND eha.Hab_Act_ID <> 0
      ORDER BY h.Hab_Nombre ASC;
    `, [id]);

    const [pasivas] = await pool.query(`
      SELECT DISTINCT
        ehp.Equipo_ID AS idEquipo,
        h.Hab_ID AS id,
        h.Hab_Nombre AS nombre
      FROM equipo_por_personaje AS ep
      INNER JOIN equipo_habilidad_pasiva AS ehp ON ehp.Equipo_ID = ep.Equipo_ID
      INNER JOIN habilidad_pasiva AS h ON h.Hab_ID = ehp.Hab_Pas_ID
      WHERE ep.Pj_ID = ? AND ehp.Hab_Pas_ID <> 0
      ORDER BY h.Hab_Nombre ASC;
    `, [id]);

    const activasPorEquipo = new Map();
    const pasivasPorEquipo = new Map();
    for (const habilidad of activas) {
      if (!activasPorEquipo.has(habilidad.idEquipo)) activasPorEquipo.set(habilidad.idEquipo, []);
      activasPorEquipo.get(habilidad.idEquipo).push({ id: habilidad.id, nombre: habilidad.nombre });
    }
    for (const habilidad of pasivas) {
      if (!pasivasPorEquipo.has(habilidad.idEquipo)) pasivasPorEquipo.set(habilidad.idEquipo, []);
      pasivasPorEquipo.get(habilidad.idEquipo).push({ id: habilidad.id, nombre: habilidad.nombre });
    }

    res.json(armas.map((arma) => ({
      ...arma,
      habilidadesActivas: activasPorEquipo.get(arma.idEquipo) || [],
      habilidadesPasivas: pasivasPorEquipo.get(arma.idEquipo) || []
    })));
  } catch (error) {
    return responderError(res, error, `armas del personaje ${req.personajeId}`);
  }
});

app.listen(PORT, () => {
  console.log(`Servidor FF9 escuchando en http://localhost:${PORT}`);
  console.log(`Base configurada: ${DATABASE}`);
  console.log("Rutas: /api/personajes, /api/objetos y /api/personajes/:id/habilidades|equipo");
});

// Cierra el pool cuando se detiene el proceso (Ctrl+C).
process.on("SIGINT", async () => {
  await pool.end();
  process.exit(0);
});
