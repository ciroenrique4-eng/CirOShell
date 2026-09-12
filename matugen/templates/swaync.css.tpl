/* ─────────────────────────────────────────────────────────────────────────
   swaync — notificaciones minimalistas, arriba a la derecha.
   Generado por matugen desde ~/.config/matugen/templates/swaync.css.tpl
   NO EDITAR ~/.config/swaync/style.css: se sobrescribe en cada wallpaper.

   Criterio: una notificación es una interrupción. Que se lea de un vistazo y
   desaparezca. Nada de bordes, cajas dentro de cajas ni sombras duras: una
   superficie, una franja de acento y jerarquía tipográfica.

   ⚠️ SELECTORES LARGOS A PROPÓSITO. El tema por defecto de swaync
   (/etc/xdg/swaync/style.css) escribe sus reglas con cadenas de tres y cinco
   clases, p. ej.:

       .notification-row .notification-background .notification { border: … }

   Un `.notification { border: none }` a secas tiene menos especificidad y
   PIERDE en silencio: la tarjeta se queda con el borde blanco del tema base y
   los estados critical/low no cambian de color. Hay que igualar la cadena.
   Para ver contra qué se compite:
       grep -nE "^\." /etc/xdg/swaync/style.css
   ───────────────────────────────────────────────────────────────────────── */

* {
    font-family: "FiraCode Nerd Font", "Noto Sans", sans-serif;
    font-size: 13px;
}

/* La fila es solo el contenedor: el fondo lo pone la tarjeta. */
.notification-row,
.notification-row:focus,
.notification-row:hover {
    background: transparent;
    outline: none;
}

.notification-row .notification-background {
    background: transparent;
}

/* ── Tarjeta ────────────────────────────────────────────────────────────── */
.notification-row .notification-background .notification {
    background: #{{colors.surface_container.default.hex_stripped}};
    border: none;
    /* Franja de acento a la izquierda: identifica la tarjeta sin encerrarla. */
    border-left: 3px solid #{{colors.primary.default.hex_stripped}};
    border-radius: 12px;
    padding: 0;
    margin: 6px 10px 0 10px;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.30);
}

/* Crítica: además de la franja, el fondo se tiñe. En paletas cálidas `error`
   y `primary` salen casi iguales, así que la franja sola no distingue nada. */
.notification-row .notification-background .notification.critical {
    background: #{{colors.error_container.default.hex_stripped}};
    border-left-color: #{{colors.error.default.hex_stripped}};
}

.notification-row .notification-background .notification.low {
    border-left-color: #{{colors.outline_variant.default.hex_stripped}};
}

.notification-row .notification-background .notification .notification-default-action {
    background: transparent;
    border: none;
    border-radius: 12px;
    padding: 0;
    transition: background 0.15s ease;
}

.notification-row .notification-background .notification .notification-default-action:hover {
    background: #{{colors.surface_container_high.default.hex_stripped}};
}

/* Solo redondear abajo cuando no hay botones de acción debajo. */
.notification-row .notification-background .notification .notification-default-action:not(:only-child) {
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
}

.notification-row .notification-background .notification .notification-default-action .notification-content {
    background: transparent;
    padding: 12px 14px;
}

/* ── Texto ──────────────────────────────────────────────────────────────── */
.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .summary {
    font-size: 13px;
    font-weight: 600;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .body {
    font-size: 12px;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
}

/* La hora es un metadato: presente, pero fuera del camino. */
.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .time {
    font-size: 10px;
    color: #{{colors.outline.default.hex_stripped}};
    margin-right: 2px;
}

.notification-row .notification-background .notification.critical .notification-default-action .notification-content .text-box .summary,
.notification-row .notification-background .notification.critical .notification-default-action .notification-content .text-box .body {
    color: #{{colors.on_error_container.default.hex_stripped}};
}

/* ── Imagen / icono ─────────────────────────────────────────────────────── */
/* El tema base las deja redondas (border-radius: 100px). Con capturas y
   miniaturas de descarga eso recorta el contenido: mejor esquinas suaves. */
.notification-row .notification-background .notification .notification-default-action .notification-content .image {
    border-radius: 9px;
    margin-right: 12px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .app-icon {
    margin-right: 10px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .body-image {
    border-radius: 9px;
    margin-top: 8px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content progressbar {
    background: #{{colors.surface_container_lowest.default.hex_stripped}};
    border-radius: 4px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content progressbar progress {
    background: #{{colors.primary.default.hex_stripped}};
    border-radius: 4px;
}

/* ── Cerrar: invisible hasta que hace falta ─────────────────────────────── */
.close-button {
    background: transparent;
    color: #{{colors.outline.default.hex_stripped}};
    border: none;
    border-radius: 8px;
    padding: 2px 6px;
    margin: 8px 8px 0 0;
    font-size: 12px;
    opacity: 0;
    transition: opacity 0.15s ease, background 0.15s ease, color 0.15s ease;
}

.notification-row:hover .close-button {
    opacity: 1;
}

.close-button:hover {
    background: #{{colors.error.default.hex_stripped}};
    color: #{{colors.on_error.default.hex_stripped}};
    opacity: 1;
}

/* ── Acciones ───────────────────────────────────────────────────────────── */
.notification-row .notification-background .notification .notification-action {
    background: #{{colors.surface_container_high.default.hex_stripped}};
    color: #{{colors.on_surface.default.hex_stripped}};
    border: none;
    border-radius: 8px;
    margin: 0 4px 8px 4px;
    padding: 6px 12px;
    font-size: 12px;
    transition: background 0.15s ease, color 0.15s ease;
}

.notification-row .notification-background .notification .notification-action:first-child {
    margin-left: 14px;
}

.notification-row .notification-background .notification .notification-action:last-child {
    margin-right: 14px;
}

.notification-row .notification-background .notification .notification-action:hover {
    background: #{{colors.primary.default.hex_stripped}};
    color: #{{colors.on_primary.default.hex_stripped}};
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-entry {
    background: #{{colors.surface_container_lowest.default.hex_stripped}};
    color: #{{colors.on_surface.default.hex_stripped}};
    border: 1px solid #{{colors.outline_variant.default.hex_stripped}};
    border-radius: 8px;
    padding: 4px 8px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button {
    background: transparent;
    color: #{{colors.primary.default.hex_stripped}};
    border: none;
    border-radius: 8px;
    margin-left: 4px;
    padding: 4px 10px;
}


/* ═══════════════════════════════════════════════════════════════════════
   Centro de notificaciones
   ═══════════════════════════════════════════════════════════════════════ */

.control-center {
    background: #{{colors.surface.default.hex_stripped}};
    border: none;
    border-radius: 16px;
    padding: 4px 0 10px 0;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.42);
}

.control-center .control-center-list {
    background: transparent;
}

.control-center .control-center-list-placeholder {
    color: #{{colors.outline_variant.default.hex_stripped}};
    font-size: 12px;
}

/* Dentro del centro las tarjetas no necesitan sombra: ya están sobre una. */
.control-center .control-center-list .notification {
    box-shadow: none;
    margin: 4px 10px;
}

/* ── Cabecera ───────────────────────────────────────────────────────────── */
.widget-title > label {
    color: #{{colors.on_surface.default.hex_stripped}};
    font-size: 15px;
    font-weight: 600;
    margin: 14px 4px 8px 16px;
}

.widget-title > button {
    background: transparent;
    color: #{{colors.outline.default.hex_stripped}};
    border: none;
    border-radius: 8px;
    font-size: 11px;
    font-weight: 600;
    margin: 14px 16px 8px 4px;
    padding: 5px 12px;
    transition: background 0.15s ease, color 0.15s ease;
}

.widget-title > button:hover {
    background: #{{colors.error.default.hex_stripped}};
    color: #{{colors.on_error.default.hex_stripped}};
}

/* ── No molestar ────────────────────────────────────────────────────────── */
.widget-dnd label {
    color: #{{colors.on_surface_variant.default.hex_stripped}};
    font-size: 12px;
    margin: 2px 4px 10px 16px;
}

.widget-dnd switch {
    background: #{{colors.surface_container_high.default.hex_stripped}};
    border: none;
    border-radius: 12px;
    margin: 2px 16px 10px 4px;
    min-height: 22px;
    min-width: 42px;
    transition: background 0.2s ease;
}

.widget-dnd switch:checked {
    background: #{{colors.primary.default.hex_stripped}};
}

.widget-dnd switch slider {
    background: #{{colors.outline.default.hex_stripped}};
    border-radius: 10px;
    min-width: 16px;
    min-height: 16px;
    transition: background 0.2s ease;
}

.widget-dnd switch:checked slider {
    background: #{{colors.on_primary.default.hex_stripped}};
}

/* ── Reproductor ────────────────────────────────────────────────────────── */
.widget-mpris {
    background: #{{colors.surface_container.default.hex_stripped}};
    border-radius: 12px;
    margin: 4px 10px 10px 10px;
    padding: 6px;
}

.widget-mpris .widget-mpris-player {
    background: transparent;
    box-shadow: none;
    padding: 6px;
}

.widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-album-art {
    border-radius: 10px;
}

.widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-title {
    font-size: 13px;
    font-weight: 600;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-subtitle {
    font-size: 11px;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
}

.widget-mpris .widget-mpris-player .mpris-overlay > box > button {
    background: transparent;
    border: none;
    border-radius: 8px;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
}

.widget-mpris .widget-mpris-player .mpris-overlay > box > button:hover {
    background: #{{colors.surface_container_high.default.hex_stripped}};
    color: #{{colors.on_surface.default.hex_stripped}};
}

/* ── Scrollbar ──────────────────────────────────────────────────────────── */
scrollbar {
    background: transparent;
    min-width: 4px;
}

scrollbar slider {
    background: #{{colors.outline_variant.default.hex_stripped}};
    border-radius: 4px;
    min-height: 40px;
}

scrollbar slider:hover {
    background: #{{colors.outline.default.hex_stripped}};
}
