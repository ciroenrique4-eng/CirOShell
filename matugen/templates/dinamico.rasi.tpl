* {
    /* ── Fondos y textos base ── */
    background:                  {{colors.surface.default.hex}};
    background-alt:              {{colors.surface_container.default.hex}};
    foreground:                  {{colors.on_surface.default.hex}};

    /* ── Tu lógica invertida para la selección ── */
    selected:                    {{colors.on_primary.default.hex}}; /* Fondo muy oscuro */
    selected-text:               {{colors.primary.default.hex}};    /* Letras de color vivo */

    /* ── Otros estados y utilidades ── */
    active:                      {{colors.surface_container_high.default.hex}};
    urgent:                      {{colors.error.default.hex}};
    border-colour:               {{colors.outline_variant.default.hex}};
    handle-colour:               {{colors.primary.default.hex}};
    
    /* ── Mapeo clásico para Rofi ── */
    normal-background:           var(background);
    normal-foreground:           var(foreground);
    urgent-background:           var(urgent);
    urgent-foreground:           var(background);
    active-background:           var(active);
    active-foreground:           var(foreground);
    
    /* ── Aquí inyectamos tu lógica de selección ── */
    selected-normal-background:  var(selected);
    selected-normal-foreground:  var(selected-text);
    
    selected-urgent-background:  var(urgent);
    selected-urgent-foreground:  var(background);
    
    selected-active-background:  var(selected);
    selected-active-foreground:  var(selected-text);
    
    alternate-normal-background: var(background-alt);
    alternate-normal-foreground: var(foreground);
    alternate-urgent-background: var(urgent);
    alternate-urgent-foreground: var(background);
    alternate-active-background: var(active);
    alternate-active-foreground: var(foreground);
}
