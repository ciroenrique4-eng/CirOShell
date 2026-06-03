* {
    font-family: FiraCode Nerd Font;
    font-size: 13px;
}

.notification-row {
    outline: none;
    margin: 4px;
}

.notification-row:focus,
.notification-row:hover {
    background: transparent;
}

/* === Popups de Notificaciones === */
.notification {
    background: #{{colors.surface_container.default.hex_stripped}};
    border: 1px solid #{{colors.outline_variant.default.hex_stripped}};
    border-radius: 12px;
    padding: 12px;
    margin: 0;
    box-shadow: 0 2px 8px rgba(0,0,0,0.35);
}

.notification-content {
    padding: 0;
}

.notification-icon, .image {
    min-width: 40px;
    min-height: 40px;
    max-width: 40px;
    max-height: 40px;
    border-radius: 8px;
    margin-right: 10px;
}

.notification-default-action {
    background: transparent;
    border-radius: 8px;
    padding: 0;
    transition: background 0.15s ease;
}

.notification-default-action:hover {
    background: #{{colors.surface_container_high.default.hex_stripped}};
}

.summary {
    font-size: 13px;
    font-weight: bold;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.body {
    font-size: 12px;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
}

.app-name, .time {
    font-size: 11px;
    color: #{{colors.outline.default.hex_stripped}};
}

.close-button {
    background: transparent;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
    border-radius: 8px;
    border: none;
    padding: 4px 6px;
    font-size: 11px;
    transition: background 0.15s ease, color 0.15s ease;
}

.close-button:hover {
    background: #{{colors.error_container.default.hex_stripped}};
    color: #{{colors.on_error_container.default.hex_stripped}};
}

.notification-action {
    background: #{{colors.secondary_container.default.hex_stripped}};
    color: #{{colors.on_secondary_container.default.hex_stripped}};
    border-radius: 8px;
    border: none;
    margin: 4px 2px;
    padding: 4px 10px;
    font-size: 12px;
    transition: background 0.15s ease, color 0.15s ease;
}

.notification-action:hover {
    background: #{{colors.primary.default.hex_stripped}};
    color: #{{colors.on_primary.default.hex_stripped}};
}

/* === Control Center === */
.control-center {
    background: #{{colors.surface.default.hex_stripped}};
    border: 1px solid #{{colors.outline_variant.default.hex_stripped}};
    border-radius: 14px;
    padding: 6px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.4);
}

.control-center-list {
    background: transparent;
}

/* === Scrollbar === */
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

.widget-title {
    color: #{{colors.on_surface.default.hex_stripped}};
    font-size: 13px;
    font-weight: bold;
    margin: 8px 6px 4px 6px;
}

.widget-title > button {
    background: #{{colors.surface_container.default.hex_stripped}};
    color: #{{colors.on_surface_variant.default.hex_stripped}};
    border-radius: 8px;
    border: none;
    font-size: 11px;
    padding: 4px 8px;
    transition: background 0.15s ease, color 0.15s ease;
}

.widget-title > button:hover {
    background: #{{colors.error_container.default.hex_stripped}};
    color: #{{colors.on_error_container.default.hex_stripped}};
}

/* === Switch de Silenciar (DND) === */
.widget-dnd {
    margin: 4px 6px;
    font-size: 12px;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.widget-dnd > switch {
    background: #{{colors.surface_container_highest.default.hex_stripped}};
    border-radius: 12px;
    border: 1px solid #{{colors.outline.default.hex_stripped}};
    min-height: 24px;
    min-width: 44px;
    transition: background 0.2s ease, border-color 0.2s ease;
}

.widget-dnd > switch:checked {
    background: #{{colors.primary.default.hex_stripped}};
    border-color: #{{colors.primary.default.hex_stripped}};
}

.widget-dnd > switch slider {
    background: #{{colors.outline.default.hex_stripped}};
    border-radius: 10px;
    min-width: 16px;
    min-height: 16px;
    transition: background 0.2s ease;
}

.widget-dnd > switch:checked slider {
    background: #{{colors.on_primary.default.hex_stripped}};
}

/* === Reproductor MPRIS === */
.widget-mpris {
    background: #{{colors.surface_container_high.default.hex_stripped}};
    border-radius: 10px;
    margin: 6px;
    padding: 8px;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.widget-mpris-title {
    font-weight: bold;
    font-size: 12px;
    color: #{{colors.on_surface.default.hex_stripped}};
}

.widget-mpris-subtitle {
    font-size: 11px;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
}

.widget-mpris > box > button,
.widget-mpris > box > box > button {
    background: transparent;
    color: #{{colors.on_surface_variant.default.hex_stripped}};
    border: none;
    border-radius: 8px;
    padding: 4px 8px;
    font-size: 14px;
    transition: background 0.15s ease, color 0.15s ease;
}

.widget-mpris > box > button:hover,
.widget-mpris > box > box > button:hover {
    background: #{{colors.primary_container.default.hex_stripped}};
    color: #{{colors.on_primary_container.default.hex_stripped}};
}

/* === Botones de Energía (Buttons Grid) === */
.widget-buttons-grid {
    background: #{{colors.surface_container.default.hex_stripped}};
    border-radius: 12px;
    margin: 6px;
    padding: 4px;
}

.widget-buttons-grid > flowbox > flowboxchild > button {
    background: transparent;
    color: #{{colors.on_surface.default.hex_stripped}};
    border-radius: 8px;
    padding: 6px 12px;
    font-size: 16px;
    transition: background 0.15s ease, color 0.15s ease;
}

.widget-buttons-grid > flowbox > flowboxchild > button:hover {
    background: #{{colors.primary_container.default.hex_stripped}};
    color: #{{colors.on_primary_container.default.hex_stripped}};
}

/* === Urgencia === */
.critical {
    border-color: #{{colors.error.default.hex_stripped}};
    border-width: 2px;
}

.low {
    opacity: 0.85;
}
