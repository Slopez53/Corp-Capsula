# Cápsula Pagos

App para llevar los pagos pendientes del negocio y del hogar. Es una **PWA**
(Progressive Web App): una sola página auto-contenida, sin servidor, sin
cuentas y sin dependencias. Todo se guarda en el dispositivo.

## Cómo se usa / instala

Al desplegar este repositorio en Netlify, la app queda disponible en
`https://<tu-sitio>/pagos/`. Desde ahí se instala como app nativa:

| Plataforma | Instalación |
|---|---|
| **iPhone / iPad** | Safari → botón Compartir → «Añadir a pantalla de inicio» |
| **Mac** | Safari → Archivo → «Añadir al Dock» (o Chrome → icono instalar en la barra de direcciones) |
| **Android** | Chrome → botón «Instalar» dentro de la app (o menú ⋮ → «Instalar app») |
| **Windows / Linux** | Chrome o Edge → icono de instalar en la barra de direcciones |

Una vez instalada funciona **sin conexión** (service worker) y con su propio
icono y ventana, como cualquier app nativa.

> También funciona abriendo `index.html` directamente en un navegador,
> aunque el modo instalable y sin conexión requiere servirse por HTTPS.

## Funciones

- **Entrada rápida en un paso**: escribe `Internet 39.99 el 15 mensual` y la
  app extrae nombre, monto, fecha y recurrencia automáticamente. Entiende
  `hoy`, `mañana`, `el 15`, `día 5`, `12/08`, `mensual`, `semanal`,
  `quincenal`, `anual`, montos con `$` y decimales con coma o punto.
- **Pagos recurrentes autónomos**: al marcar pagado un pago recurrente, el
  siguiente se crea solo con la fecha correcta.
- **Agrupación automática**: Vencidos · Hoy · Esta semana · Más adelante,
  con totales por grupo y resumen (pendiente, vencido, pagado del mes).
- **Calendario Google**: cada pago tiene «Añadir a Google Calendar»
  (con recurrencia incluida) que se vincula a tu cuenta Google.
- **Calendario Apple / Outlook**: descarga `.ics` por pago o de todos los
  pendientes, con alarma un día antes. Al abrirlo en iPhone/Mac se añade
  al calendario de iCloud.
- **Recordatorios**: notificaciones del dispositivo N días antes del
  vencimiento (configurable).
- **Personalizable**: tema claro/oscuro/automático, 7 colores de acento +
  color libre, nombre de la app, moneda (12 divisas), categorías ilimitadas
  con nombre y color propios.
- **Deshacer** en cada acción (añadir, pagar, eliminar) — sin diálogos de
  confirmación que estorben.
- **Copia de seguridad**: exporta/importa todos tus datos en JSON.

## Archivos

- `index.html` — toda la app (HTML + CSS + JS, sin dependencias)
- `sw.js` — service worker para funcionar sin conexión
- `manifest.webmanifest` + iconos PNG — instalación como app
