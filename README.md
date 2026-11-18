# Final Fantasy IX · Menú de Memoria

Aplicación web local para explorar el catálogo de `inv_ff9` mediante **MySQL + Node.js + Express + mysql2 + HTML + CSS + JavaScript**. La interfaz se inspira en el menú clásico de Final Fantasy IX.

## 1. Estructura del proyecto

```text
Proyecto_FF9_Web/
├── backend/
│   ├── .env.example
│   ├── datos.sql
│   ├── package.json
│   ├── package-lock.json
│   └── server.js
├── frontend/
│   ├── index.html
│   └── assets/
│       ├── css/style.css
│       ├── js/script.js
│       └── img/
│           ├── header-ff9.jpg
│           ├── personajes/*.jpg
├── diagrama_bd.png
├── README.md
└── README.rd
```

## 2. Requisitos

- MySQL Server y MySQL Workbench.
- Node.js y npm.
- Visual Studio Code y Live Server.
- Navegador moderno.

## 3. Base de datos `inv_ff9`

El backend consulta las tablas originales del dump: `personaje`, `activa_pj`, `habilidad_activa`, `pasiva_pj`, `habilidad_pasiva`, `objeto`, `tipo`, `equipo`, `atributo`, `equipo_por_personaje`, `equipo_habilidad_activa` y `equipo_habilidad_pasiva`.

**Advertencia:** `backend/datos.sql` es un dump completo y contiene `DROP TABLE IF EXISTS`. Si ya tienes `inv_ff9` con los datos importados, no vuelvas a ejecutar el dump sin hacer una copia de seguridad. La aplicación funciona con las tablas existentes y no necesita recrearlas.

## 4. Configurar MySQL

Copia la plantilla de configuración a `.env` desde la carpeta `backend`.

**PowerShell:**

```powershell
Copy-Item .env.example .env
```

Abre `backend/.env` y configura las credenciales de tu servidor MySQL:

```env
PORT=3000
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=inv_ff9
DB_USER=root
DB_PASSWORD=TU_CLAVE_MYSQL
FRONTEND_URL=http://127.0.0.1:5500
```

Sustituye `TU_CLAVE_MYSQL` por tu contraseña. Si tu usuario no tiene contraseña, deja `DB_PASSWORD=` vacío. El backend carga este archivo desde su propia carpeta, aunque la terminal se abra desde otra ubicación.

No compartas el archivo `.env` ni lo subas a Git. Está excluido por `.gitignore`.

## 5. Iniciar el backend

Abre una terminal en `Proyecto_FF9_Web/backend` y ejecuta:

```bash
npm install
npm run dev
```

La terminal debe indicar que Express está escuchando en `http://localhost:3000` y que la base configurada es `inv_ff9`.

## 6. Rutas locales utilizadas por el frontend

Estas rutas pertenecen al servidor Express de este proyecto. No se consume ninguna API externa ni existe una ruta `/api/health`.

| Ruta | Datos consultados |
|---|---|
| `GET /api/personajes` | Ocho personajes, estadísticas base de nivel 1 y modificadores de crecimiento |
| `GET /api/objetos` | Catálogo `objeto` con su categoría de `tipo` |
| `GET /api/personajes/:id/habilidades` | Habilidades activas y pasivas relacionadas al personaje |
| `GET /api/personajes/:id/equipo` | Armas permitidas, atributos y habilidades vinculadas a cada arma |

Puedes abrir estas rutas directamente en el navegador para comprobar las respuestas JSON. Por ejemplo, `http://localhost:3000/api/personajes/1/habilidades` y `http://localhost:3000/api/personajes/1/equipo`.

Si el navegador indica que no se puede conectar a `localhost:3000`, confirma que el proceso `npm run dev` sigue activo. Si recibes un error JSON, revisa el código del error y el mensaje de la terminal; el backend no sustituye los registros fallidos por datos de demostración.

## 7. Iniciar el frontend

1. Abre `Proyecto_FF9_Web/frontend` en Visual Studio Code.
2. Haz clic derecho en `index.html`.
3. Selecciona **Open with Live Server**.
4. Utiliza la dirección `http://127.0.0.1:5500` o el puerto autorizado en `backend/server.js`.

Mantén MySQL Server, Express y Live Server activos mientras utilizas la aplicación.

## 8. Funcionamiento de la interfaz

- La pantalla principal está limitada a la altura visible del navegador. El panel izquierdo muestra cuatro personajes y permite desplazarse para ver los otros cuatro.
- Al entrar, cada personaje comienza en nivel 1.
- `Item` abre una ventana emergente con los registros de `objeto`, búsqueda por nombre/descripción y filtro por tipo.
- `Ability` muestra una ficha superior del personaje (retrato, nivel, HP, MP y piedras mágicas) y una única tabla desplazable en la zona inferior. Cada fila alinea una habilidad a la izquierda y otra a la derecha, con una sola barra de desplazamiento compartida. Las pestañas cambian entre habilidades activas y pasivas.
- El orden de los personajes se controla en `backend/server.js`, mediante `ORDEN_MENU`. Los ID actuales son: 1 Zidane, 2 Steiner, 3 Vivi, 4 Garnet, 5 Freya, 6 Quina, 7 Eiko y 8 Amarant. El orden aplicado es `[1, 3, 4, 2, 7, 5, 6, 8]`.
- En la pestaña de habilidades pasivas se pueden activar/desactivar habilidades. El coste de piedras mágicas se descuenta del límite calculado del personaje. Esta selección se guarda en `localStorage`, ya que el dump no contiene un estado de habilidad equipada.
- `Equip` reproduce la distribución del menú original: estadísticas del personaje a la izquierda; selector de armas en la parte superior derecha; habilidades vinculadas al arma seleccionada en la parte inferior derecha.
- Al abrir `Ability` o `Equip`, el personaje seleccionado sube un nivel automáticamente.
- El arma elegida se refleja en las estadísticas de `Equip` y se guarda en `localStorage`. Los valores de ataque/defensa/evasión pertenecen al arma; los bonos de fuerza, magia, velocidad y espíritu del equipo se acumulan al subir nivel, conforme al sistema de crecimiento implementado.
- `Status` no se presenta como una pantalla separada: las estadísticas ya aparecen en el menú `Equip`, como en la referencia solicitada.
- El reloj muestra la hora local del computador. Los Guiles se generan aleatoriamente entre 100 y 100.000 al cargar la página.

## 9. Límites reales del dump SQL

Para evitar mostrar datos ficticios, se respetan estas limitaciones del modelo entregado:

1. `objeto` contiene 274 registros de catálogo, pero no hay una tabla que guarde cantidades o unidades poseídas de cada objeto. Por eso `Item` muestra el catálogo, no un inventario con cantidades.
2. `equipo_por_personaje` relaciona armas (`tipo` = `Arma`) con los personajes. El dump no establece una armadura actualmente equipada ni otros espacios de equipamiento por personaje; esta versión permite equipar las armas que sí están relacionadas.
3. `personaje` contiene `Pj_Vit_Max`, `Pj_PM_Max` y `Pj_PieMag_Max`, pero no son las estadísticas de nivel 1 del juego en todos los casos y no hay tabla de niveles/experiencia. Las estadísticas iniciales de nivel 1 y las tablas de crecimiento se han tomado de referencias de FFIX; el avance se guarda localmente porque el SQL no tiene columnas para persistirlo.
4. La tabla `inventario` contiene datos de registros/partidas (sección, personaje, tiempo, guiles y locación), no una relación de cantidades de objetos.

## 10. Estadísticas y crecimiento

La página inicia los personajes con los valores de nivel 1 de FFIX. Las estadísticas derivadas de cada nivel se calculan con las fórmulas de crecimiento del juego y con los modificadores HP/MP por nivel. Las bonificaciones de equipo se suman al contador de crecimiento cuando se gana un nivel con esa arma equipada. Los valores exactos pueden consultarse en las referencias incluidas al final de este documento.

## Referencias de estadísticas originales

- KADFC, *Final Fantasy IX Max Stats FAQ*: fórmulas de estadísticas, bonificaciones de equipo y modificadores de HP/MP. https://www.neoseeker.com/final-fantasy-ix/faqs/187371-max-stats.html
- *Final Fantasy IX – Level One Character Stats*: tabla de estadísticas base de nivel 1. https://www.supercheats.com/playstation/walkthroughs/finalfantasyix-walkthrough08.txt
