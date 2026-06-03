// ─────────────────────────────────────────────
// VSCode settings.json — CirOScript
// ─────────────────────────────────────────────
{
// ── Colores Nativos de la Interfaz ───────────────────────────────
    "workbench.colorCustomizations": {

        // ── Fondos principales ──
        "editor.background":                          "{{colors.surface.default.hex}}",
        "sideBar.background":                         "{{colors.surface_container.default.hex}}",
        "activityBar.background":                     "{{colors.surface_container_low.default.hex}}",
        "panel.background":                           "{{colors.surface_container_high.default.hex}}",
        "terminal.background":                        "{{colors.surface.default.hex}}",

        // ── Pestañas (Tabs) ──
        "editorGroupHeader.tabsBackground":           "{{colors.surface_container.default.hex}}",
        "tab.activeBackground":                       "{{colors.surface_container_highest.default.hex}}",
        "tab.inactiveBackground":                     "{{colors.surface_container.default.hex}}",
        "tab.activeForeground":                       "{{colors.on_surface.default.hex}}",
        "tab.inactiveForeground":                     "{{colors.on_surface_variant.default.hex}}",
        "tab.border":                                 "{{colors.outline_variant.default.hex}}",
        "tab.activeBorder":                           "{{colors.primary.default.hex}}",
        "tab.hoverBackground":                        "{{colors.surface_container_high.default.hex}}",
        "tab.hoverForeground":                        "{{colors.on_surface.default.hex}}",

        // ── Barra de Título ──
        "titleBar.activeBackground":                  "{{colors.surface_container_low.default.hex}}",
        "titleBar.activeForeground":                  "{{colors.on_surface.default.hex}}",
        "titleBar.inactiveBackground":                "{{colors.surface_container_low.default.hex}}",
        "titleBar.inactiveForeground":                "{{colors.on_surface_variant.default.hex}}",
        "titleBar.border":                            "{{colors.outline_variant.default.hex}}",

        // ── Barra de Estado ──
        "statusBar.background":                       "{{colors.surface_container_low.default.hex}}",
        "statusBar.foreground":                       "{{colors.on_surface_variant.default.hex}}",
        "statusBar.noFolderBackground":               "{{colors.surface_container_low.default.hex}}",
        "statusBar.border":                           "{{colors.outline_variant.default.hex}}",
        "statusBarItem.hoverBackground":              "{{colors.surface_container_high.default.hex}}",
        "statusBarItem.remoteBackground":             "{{colors.primary_container.default.hex}}",
        "statusBarItem.remoteForeground":             "{{colors.on_primary_container.default.hex}}",
        "statusBarItem.errorBackground":              "{{colors.error_container.default.hex}}",
        "statusBarItem.errorForeground":              "{{colors.on_error_container.default.hex}}",
        "statusBarItem.warningBackground":            "{{colors.tertiary_container.default.hex}}",
        "statusBarItem.warningForeground":            "{{colors.on_tertiary_container.default.hex}}",

        // ── Widgets y Popups ──
        "editorWidget.background":                    "{{colors.surface_container_high.default.hex}}",
        "editorWidget.border":                        "{{colors.outline_variant.default.hex}}",
        "editorWidget.foreground":                    "{{colors.on_surface.default.hex}}",
        "editorSuggestWidget.background":             "{{colors.surface_container_highest.default.hex}}",
        "editorSuggestWidget.border":                 "{{colors.outline_variant.default.hex}}",
        "editorSuggestWidget.foreground":             "{{colors.on_surface.default.hex}}",
        "editorSuggestWidget.selectedBackground":     "{{colors.primary_container.default.hex}}",
        "editorSuggestWidget.selectedForeground":     "{{colors.on_primary_container.default.hex}}",
        "editorSuggestWidget.highlightForeground":    "{{colors.primary.default.hex}}",
        "editorSuggestWidget.focusHighlightForeground": "{{colors.on_primary_container.default.hex}}",
        "editorHoverWidget.background":               "{{colors.surface_container_highest.default.hex}}",
        "editorHoverWidget.border":                   "{{colors.outline_variant.default.hex}}",
        "editorHoverWidget.foreground":               "{{colors.on_surface.default.hex}}",
        "menu.background":                            "{{colors.surface_container_high.default.hex}}",
        "menu.foreground":                            "{{colors.on_surface.default.hex}}",
        "menu.selectionBackground":                   "{{colors.primary_container.default.hex}}",
        "menu.selectionForeground":                   "{{colors.on_primary_container.default.hex}}",
        "menu.separatorBackground":                   "{{colors.outline_variant.default.hex}}",
        "menubar.selectionBackground":                "{{colors.surface_container_high.default.hex}}",
        "menubar.selectionForeground":                "{{colors.on_surface.default.hex}}",
        "quickInput.background":                      "{{colors.surface_container_high.default.hex}}",
        "quickInput.foreground":                      "{{colors.on_surface.default.hex}}",
        "quickInputList.focusBackground":             "{{colors.primary_container.default.hex}}",
        "quickInputList.focusForeground":             "{{colors.on_primary_container.default.hex}}",
        "quickInputList.focusIconForeground":         "{{colors.primary.default.hex}}",
        "notifications.background":                   "{{colors.surface_container_highest.default.hex}}",
        "notifications.foreground":                   "{{colors.on_surface.default.hex}}",
        "notifications.border":                       "{{colors.outline_variant.default.hex}}",
        "notificationCenterHeader.background":        "{{colors.surface_container_high.default.hex}}",
        "notificationLink.foreground":                "{{colors.primary.default.hex}}",
        "dropdown.background":                        "{{colors.surface_container_high.default.hex}}",
        "dropdown.foreground":                        "{{colors.on_surface.default.hex}}",
        "dropdown.border":                            "{{colors.outline_variant.default.hex}}",

        // ── Controles de Formulario ──
        "input.background":                           "{{colors.surface_container.default.hex}}",
        "input.foreground":                           "{{colors.on_surface.default.hex}}",
        "input.border":                               "{{colors.outline_variant.default.hex}}",
        "input.placeholderForeground":                "{{colors.outline.default.hex}}",
        "inputOption.activeBackground":               "{{colors.primary_container.default.hex}}",
        "inputOption.activeForeground":               "{{colors.on_primary_container.default.hex}}",
        "inputOption.activeBorder":                   "{{colors.primary.default.hex}}",
        "checkbox.background":                        "{{colors.surface_container.default.hex}}",
        "checkbox.border":                            "{{colors.outline.default.hex}}",
        "checkbox.foreground":                        "{{colors.on_surface.default.hex}}",
        "button.background":                          "{{colors.primary.default.hex}}",
        "button.foreground":                          "{{colors.on_primary.default.hex}}",
        "button.hoverBackground":                     "{{colors.primary_container.default.hex}}",
        "button.secondaryBackground":                 "{{colors.secondary_container.default.hex}}",
        "button.secondaryForeground":                 "{{colors.on_secondary_container.default.hex}}",

        // ── Bordes y separadores ──
        "focusBorder":                                "{{colors.primary.default.hex}}",
        "panel.border":                               "{{colors.outline_variant.default.hex}}",
        "sideBar.border":                             "{{colors.outline_variant.default.hex}}",
        "activityBar.border":                         "{{colors.outline_variant.default.hex}}",
        "editorGroup.border":                         "{{colors.outline_variant.default.hex}}",
        "editorGroup.dropBackground":                 "{{colors.primary_container.default.hex}}20",

        // ── Texto de la Interfaz ──
        "editor.foreground":                          "{{colors.on_surface.default.hex}}",
        "sideBar.foreground":                         "{{colors.on_surface_variant.default.hex}}",
        "activityBar.foreground":                     "{{colors.on_surface.default.hex}}",
        "activityBar.inactiveForeground":             "{{colors.on_surface_variant.default.hex}}",
        "activityBar.activeBackground":               "{{colors.surface_container.default.hex}}",

        // ── Sección de Sidebar ──
        "sideBarSectionHeader.background":            "{{colors.surface_container_high.default.hex}}",
        "sideBarSectionHeader.foreground":            "{{colors.on_surface_variant.default.hex}}",
        "sideBarSectionHeader.border":                "{{colors.outline_variant.default.hex}}",

        // ── Alertas del Editor ──
        "editorError.foreground":                     "{{colors.error.default.hex}}",
        "editorError.border":                         "{{colors.error.default.hex}}30",
        "errorForeground":                            "{{colors.error.default.hex}}",
        "editorWarning.foreground":                   "{{colors.tertiary.default.hex}}",
        "editorWarning.border":                       "{{colors.tertiary.default.hex}}30",
        "editorInfo.foreground":                      "{{colors.secondary.default.hex}}",
        "editorHint.foreground":                      "{{colors.on_surface_variant.default.hex}}",

        // ── Números de Línea y Gutter ──
        "editorLineNumber.foreground":                "{{colors.on_surface_variant.default.hex}}",
        "editorLineNumber.activeForeground":          "{{colors.primary.default.hex}}",
        "editorGutter.background":                    "{{colors.surface.default.hex}}",
        "editorGutter.modifiedBackground":            "{{colors.primary.default.hex}}",
        "editorGutter.addedBackground":               "{{colors.secondary.default.hex}}",
        "editorGutter.deletedBackground":             "{{colors.error.default.hex}}",

        // ── Cursor ──
        "editorCursor.foreground":                    "{{colors.primary.default.hex}}",
        "editorCursor.background":                    "{{colors.surface.default.hex}}",
        "terminalCursor.foreground":                  "{{colors.primary.default.hex}}",
        "terminalCursor.background":                  "{{colors.surface.default.hex}}",

        // ── Selección y Resaltado ──
        "editor.selectionBackground":                 "{{colors.primary_container.default.hex}}55",
        "editor.selectionHighlightBackground":        "{{colors.primary_container.default.hex}}30",
        "editor.inactiveSelectionBackground":         "{{colors.surface_container_high.default.hex}}",
        "editor.wordHighlightBackground":             "{{colors.secondary_container.default.hex}}40",
        "editor.wordHighlightStrongBackground":       "{{colors.secondary_container.default.hex}}60",
        "editor.findMatchBackground":                 "{{colors.tertiary_container.default.hex}}80",
        "editor.findMatchHighlightBackground":        "{{colors.tertiary_container.default.hex}}40",
        "editor.rangeHighlightBackground":            "{{colors.primary.default.hex}}12",
        "editor.lineHighlightBackground":             "{{colors.primary.default.hex}}15",
        "editor.lineHighlightBorder":                 "#00000000",

        // ── Guías de Indentación ──
        "editorIndentGuide.background1":              "{{colors.outline_variant.default.hex}}",
        "editorIndentGuide.activeBackground1":        "{{colors.primary.default.hex}}",
        "editorIndentGuide.background":               "{{colors.outline_variant.default.hex}}",
        "editorIndentGuide.activeBackground":         "{{colors.primary.default.hex}}",

        // ── Explorador de Archivos y Listas ──
        "list.activeSelectionBackground":             "{{colors.primary_container.default.hex}}",
        "list.activeSelectionForeground":             "{{colors.on_primary_container.default.hex}}",
        "list.inactiveSelectionBackground":           "{{colors.surface_container_high.default.hex}}",
        "list.inactiveSelectionForeground":           "{{colors.on_surface.default.hex}}",
        "list.focusBackground":                       "{{colors.primary_container.default.hex}}",
        "list.focusForeground":                       "{{colors.on_primary_container.default.hex}}",
        "list.hoverBackground":                       "{{colors.surface_container_highest.default.hex}}",
        "list.highlightForeground":                   "{{colors.primary.default.hex}}",

        // ── Barras de Desplazamiento ──
        "scrollbar.shadow":                           "{{colors.surface_container_lowest.default.hex}}",
        "scrollbarSlider.background":                 "{{colors.on_surface.default.hex}}20",
        "scrollbarSlider.hoverBackground":            "{{colors.on_surface.default.hex}}40",
        "scrollbarSlider.activeBackground":           "{{colors.primary.default.hex}}60",

        // ── Breadcrumbs ──
        "breadcrumb.background":                      "{{colors.surface.default.hex}}",
        "breadcrumb.foreground":                      "{{colors.outline.default.hex}}",
        "breadcrumb.focusForeground":                 "{{colors.primary.default.hex}}",
        "breadcrumb.activeSelectionForeground":       "{{colors.on_surface.default.hex}}",
        "breadcrumbPicker.background":                "{{colors.surface_container_high.default.hex}}",

        // ── Badges ──
        "activityBarBadge.background":                "{{colors.primary.default.hex}}",
        "activityBarBadge.foreground":                "{{colors.on_primary.default.hex}}",
        "badge.background":                           "{{colors.primary_container.default.hex}}",
        "badge.foreground":                           "{{colors.on_primary_container.default.hex}}",

        // ── Peek View ──
        "peekView.border":                            "{{colors.primary.default.hex}}",
        "peekViewEditor.background":                  "{{colors.surface_container.default.hex}}",
        "peekViewEditorGutter.background":            "{{colors.surface_container.default.hex}}",
        "peekViewEditor.matchHighlightBackground":    "{{colors.tertiary_container.default.hex}}60",
        "peekViewResult.background":                  "{{colors.surface_container_high.default.hex}}",
        "peekViewResult.foreground":                  "{{colors.on_surface.default.hex}}",
        "peekViewResult.selectionBackground":         "{{colors.primary_container.default.hex}}",
        "peekViewResult.selectionForeground":         "{{colors.on_primary_container.default.hex}}",
        "peekViewResult.matchHighlightBackground":    "{{colors.tertiary_container.default.hex}}40",
        "peekViewTitle.background":                   "{{colors.surface_container_highest.default.hex}}",
        "peekViewTitleLabel.foreground":              "{{colors.on_surface.default.hex}}",
        "peekViewTitleDescription.foreground":        "{{colors.on_surface_variant.default.hex}}",

        // ── Overview Ruler ──
        "editorOverviewRuler.border":                 "{{colors.outline_variant.default.hex}}",
        "editorOverviewRuler.findMatchForeground":    "{{colors.tertiary.default.hex}}",
        "editorOverviewRuler.errorForeground":        "{{colors.error.default.hex}}",
        "editorOverviewRuler.warningForeground":      "{{colors.tertiary.default.hex}}",
        "editorOverviewRuler.modifiedForeground":     "{{colors.primary.default.hex}}",
        "editorOverviewRuler.addedForeground":        "{{colors.secondary.default.hex}}",
        "editorOverviewRuler.deletedForeground":      "{{colors.error.default.hex}}",

        // ── Decoraciones Git ──
        "gitDecoration.addedResourceForeground":      "{{colors.secondary.default.hex}}",
        "gitDecoration.modifiedResourceForeground":   "{{colors.primary.default.hex}}",
        "gitDecoration.deletedResourceForeground":    "{{colors.error.default.hex}}",
        "gitDecoration.untrackedResourceForeground":  "{{colors.tertiary.default.hex}}",
        "gitDecoration.ignoredResourceForeground":    "{{colors.outline.default.hex}}",
        "gitDecoration.conflictingResourceForeground":"{{colors.on_error_container.default.hex}}",
        "gitDecoration.renamedResourceForeground":    "{{colors.tertiary.default.hex}}",

        // ── Rainbow Brackets ──
        "editorBracketHighlight.foreground1":         "{{colors.primary.default.hex}}",
        "editorBracketHighlight.foreground2":         "{{colors.secondary.default.hex}}",
        "editorBracketHighlight.foreground3":         "{{colors.tertiary.default.hex}}",
        "editorBracketHighlight.foreground4":         "{{colors.on_error_container.default.hex}}",
        "editorBracketHighlight.foreground5":         "{{colors.on_primary_container.default.hex}}",
        "editorBracketHighlight.foreground6":         "{{colors.on_secondary_container.default.hex}}",
        "editorBracketHighlight.unexpectedBracket.foreground": "{{colors.error.default.hex}}",

        // ── Terminal ANSI ──
        "terminal.foreground":                        "{{colors.on_surface.default.hex}}",
        "terminal.selectionBackground":               "{{colors.primary_container.default.hex}}55",
        "terminal.ansiBlack":                         "{{colors.surface_container.default.hex}}",
        "terminal.ansiBrightBlack":                   "{{colors.surface_container_highest.default.hex}}",
        "terminal.ansiRed":                           "{{colors.error.default.hex}}",
        "terminal.ansiBrightRed":                     "{{colors.on_error_container.default.hex}}",
        "terminal.ansiGreen":                         "{{colors.secondary.default.hex}}",
        "terminal.ansiBrightGreen":                   "{{colors.on_secondary_container.default.hex}}",
        "terminal.ansiYellow":                        "{{colors.on_error_container.default.hex}}",
        "terminal.ansiBrightYellow":                  "{{colors.tertiary.default.hex}}",
        "terminal.ansiBlue":                          "{{colors.primary.default.hex}}",
        "terminal.ansiBrightBlue":                    "{{colors.on_primary_container.default.hex}}",
        "terminal.ansiMagenta":                       "{{colors.tertiary.default.hex}}",
        "terminal.ansiBrightMagenta":                 "{{colors.on_tertiary_container.default.hex}}",
        "terminal.ansiCyan":                          "{{colors.secondary.default.hex}}",
        "terminal.ansiBrightCyan":                    "{{colors.on_secondary_container.default.hex}}",
        "terminal.ansiWhite":                         "{{colors.on_surface_variant.default.hex}}",
        "terminal.ansiBrightWhite":                   "{{colors.on_surface.default.hex}}",

        // ── Barra de Progreso y enlaces ──
        "progressBar.background":                     "{{colors.primary.default.hex}}",
        "textLink.foreground":                        "{{colors.primary.default.hex}}",
        "textLink.activeForeground":                  "{{colors.on_primary_container.default.hex}}",
        "editorLink.activeForeground":                "{{colors.on_primary_container.default.hex}}"
    },

    // ── Colores de Sintaxis ──────────────────────────────────────────────
    "editor.tokenColorCustomizations": {
        // Atajos rápidos (aplican a todos los lenguajes)
        "comments":  "{{colors.outline.default.hex}}",
        "strings":   "{{colors.on_tertiary_container.default.hex}}",
        "keywords":  "{{colors.on_primary_container.default.hex}}",
        "variables": "{{colors.on_surface.default.hex}}",
        "functions": "{{colors.on_secondary_container.default.hex}}",
        "numbers":   "{{colors.on_error_container.default.hex}}",

        "textMateRules": [

            // ── Operadores ──
            {
                "scope": ["keyword.operator", "punctuation.accessor", "keyword.operator.type.annotation"],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}" }
            },

            // ── Constantes: booleanos, null, undefined, enums ──
            {
                "scope": [
                    "constant.language",
                    "constant.other",
                    "variable.other.constant",
                    "variable.other.enummember"
                ],
                "settings": { "foreground": "{{colors.on_error_container.default.hex}}" }
            },

            // ── Tipos, clases e interfaces ──
            {
                "scope": [
                    "entity.name.type",
                    "entity.name.class",
                    "entity.name.interface",
                    "support.type",
                    "support.class",
                    "storage.type.class",
                    "storage.type.interface"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },

            // ── Nombres de funciones y métodos ──
            {
                "scope": [
                    "entity.name.function",
                    "entity.name.function.method",
                    "support.function",
                    "meta.function-call entity.name.function"
                ],
                "settings": { "foreground": "{{colors.on_secondary_container.default.hex}}" }
            },

            // ── Built-ins del lenguaje ──
            {
                "scope": ["support.function.builtin"],
                "settings": { "foreground": "{{colors.primary.default.hex}}" }
            },

            // ── this / self / super ──
            {
                "scope": [
                    "variable.language.this",
                    "variable.language.self",
                    "variable.language.super",
                    "variable.language.special"
                ],
                "settings": { "foreground": "{{colors.secondary.default.hex}}", "fontStyle": "italic" }
            },

            // ── Parámetros de función ──
            {
                "scope": ["variable.parameter"],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}", "fontStyle": "italic" }
            },

            // ── Propiedades de objetos ──
            {
                "scope": [
                    "variable.other.property",
                    "support.type.property-name",
                    "meta.object-literal.key",
                    "meta.object.member"
                ],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}" }
            },

            // ── Namespaces y módulos importados ──
            {
                "scope": [
                    "entity.name.namespace",
                    "entity.name.module",
                    "variable.other.object.namespace"
                ],
                "settings": { "foreground": "{{colors.secondary.default.hex}}" }
            },

            // ── Decoradores y anotaciones ──
            {
                "scope": [
                    "entity.other.attribute-name",
                    "meta.decorator",
                    "punctuation.decorator"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },

            // ── Expresiones regulares ──
            {
                "scope": [
                    "string.regexp",
                    "constant.other.character-class.regexp",
                    "keyword.operator.quantifier.regexp",
                    "punctuation.definition.group.regexp"
                ],
                "settings": { "foreground": "{{colors.on_error_container.default.hex}}" }
            },

            // ── Puntuación y delimitadores ──
            {
                "scope": [
                    "punctuation.definition.block",
                    "punctuation.separator",
                    "punctuation.terminator",
                    "meta.brace.round",
                    "meta.brace.curly",
                    "meta.brace.square"
                ],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}" }
            },

            // ── HTML — Etiquetas ──
            {
                "scope": ["entity.name.tag", "meta.tag.sgml", "meta.tag"],
                "settings": { "foreground": "{{colors.on_primary_container.default.hex}}" }
            },
            // ── HTML — Atributos ──
            {
                "scope": ["entity.other.attribute-name.html"],
                "settings": { "foreground": "{{colors.secondary.default.hex}}" }
            },
            // ── HTML — Valores de atributos ──
            {
                "scope": ["string.quoted.double.html", "string.quoted.single.html"],
                "settings": { "foreground": "{{colors.on_tertiary_container.default.hex}}" }
            },

            // ── CSS / SCSS — Selectores (clases, IDs, etiquetas) ──
            {
                "scope": [
                    "entity.other.attribute-name.class.css",
                    "entity.other.attribute-name.id.css",
                    "entity.name.tag.css",
                    "source.css keyword.control"
                ],
                "settings": { "foreground": "{{colors.on_primary_container.default.hex}}" }
            },
            // ── CSS / SCSS — Propiedades ──
            {
                "scope": [
                    "support.type.property-name.css",
                    "meta.property-name.css",
                    "support.type.property-name.scss"
                ],
                "settings": { "foreground": "{{colors.on_surface.default.hex}}" }
            },
            // ── CSS / SCSS — Valores ──
            {
                "scope": [
                    "support.constant.property-value.css",
                    "meta.property-value.css",
                    "support.constant.color",
                    "constant.other.color"
                ],
                "settings": { "foreground": "{{colors.on_tertiary_container.default.hex}}" }
            },
            // ── SCSS — Variables ──
            {
                "scope": ["variable.scss", "variable.sass"],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },

            // ── JSON — Claves ──
            {
                "scope": ["support.type.property-name.json"],
                "settings": { "foreground": "{{colors.on_secondary_container.default.hex}}" }
            },
            // ── YAML — Claves ──
            {
                "scope": ["entity.name.tag.yaml", "support.type.property-name.yaml"],
                "settings": { "foreground": "{{colors.on_secondary_container.default.hex}}" }
            },

            // ── Markdown — Encabezados ──
            {
                "scope": [
                    "markup.heading",
                    "entity.name.section.markdown",
                    "punctuation.definition.heading.markdown"
                ],
                "settings": { "foreground": "{{colors.on_primary_container.default.hex}}", "fontStyle": "bold" }
            },
            // ── Markdown — Negrita ──
            {
                "scope": ["markup.bold"],
                "settings": { "foreground": "{{colors.on_surface.default.hex}}", "fontStyle": "bold" }
            },
            // ── Markdown — Cursiva ──
            {
                "scope": ["markup.italic"],
                "settings": { "foreground": "{{colors.on_surface.default.hex}}", "fontStyle": "italic" }
            },
            // ── Markdown — Código inline y bloques ──
            {
                "scope": [
                    "markup.inline.raw.string.markdown",
                    "markup.fenced_code.block.markdown",
                    "fenced_code.block.language"
                ],
                "settings": { "foreground": "{{colors.on_tertiary_container.default.hex}}" }
            },
            // ── Markdown — URLs y enlaces ──
            {
                "scope": ["markup.underline.link", "string.other.link"],
                "settings": { "foreground": "{{colors.primary.default.hex}}" }
            },

            // ── Python — Decoradores ──
            {
                "scope": [
                    "meta.function.decorator.python",
                    "entity.name.function.decorator.python"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── Python — Tipos y clases ──
            {
                "scope": [
                    "support.type.python",
                    "entity.name.type.class.python",
                    "support.class.exception.python"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── Python — Parámetros ──
            {
                "scope": [
                    "variable.parameter.function.language.python",
                    "meta.function-call.arguments.python"
                ],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}", "fontStyle": "italic" }
            },
            // ── Python — f-strings ──
            {
                "scope": [
                    "meta.fstring.python",
                    "source.python string.quoted.substring"
                ],
                "settings": { "foreground": "{{colors.on_tertiary_container.default.hex}}" }
            },

            // ── TypeScript / JavaScript — Tipos primitivos y almacenamiento ──
            {
                "scope": [
                    "storage.type.ts",
                    "storage.type.js",
                    "keyword.type.ts",
                    "keyword.type.js"
                ],
                "settings": { "foreground": "{{colors.on_primary_container.default.hex}}" }
            },
            // ── TypeScript — Interfaces y tipos ──
            {
                "scope": [
                    "entity.name.type.ts",
                    "entity.name.type.interface.ts",
                    "entity.name.type.alias.ts"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── JS / TS — Expresiones en template literals ${...} ──
            {
                "scope": [
                    "punctuation.definition.template-expression",
                    "meta.template.expression"
                ],
                "settings": { "foreground": "{{colors.on_error_container.default.hex}}" }
            },

            // ── PHP — Etiquetas de apertura <?php y cierre ?> ──
            {
                "scope": [
                    "punctuation.section.embedded.begin.php",
                    "punctuation.section.embedded.end.php"
                ],
                "settings": { "foreground": "{{colors.on_error_container.default.hex}}", "fontStyle": "bold" }
            },
            // ── PHP — Variables ($var) y el signo $ ──
            {
                "scope": [
                    "variable.other.php",
                    "variable.other.global.php",
                    "variable.other.global.safer.php",
                    "punctuation.definition.variable.php"
                ],
                "settings": { "foreground": "{{colors.on_surface.default.hex}}" }
            },
            // ── PHP — Acceso a propiedades ($obj->prop) ──
            {
                "scope": ["variable.other.property.php"],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}" }
            },
            // ── PHP — Modificadores de visibilidad (public, private, protected, static, abstract) ──
            {
                "scope": [
                    "storage.modifier.php",
                    "storage.modifier.visibility.set.php"
                ],
                "settings": { "foreground": "{{colors.on_primary_container.default.hex}}" }
            },
            // ── PHP — Tipos nativos (int, string, bool, void, array, callable...) ──
            {
                "scope": [
                    "storage.type.php",
                    "keyword.other.type.php",
                    "keyword.other.type.never.php",
                    "keyword.operator.nullable-type.php"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── PHP — Clases y excepciones nativas ──
            {
                "scope": [
                    "support.class.php",
                    "support.class.builtin.php",
                    "support.class.exception.php"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── PHP — Funciones nativas (array_map, strlen, json_encode...) ──
            {
                "scope": ["support.function.php", "support.function.construct.php"],
                "settings": { "foreground": "{{colors.primary.default.hex}}" }
            },
            // ── PHP — Constantes nativas (PHP_EOL, TRUE, NULL, E_ALL...) ──
            {
                "scope": [
                    "support.constant.core.php",
                    "support.constant.ext.php",
                    "support.constant.std.php",
                    "support.constant.parser-token.php"
                ],
                "settings": { "foreground": "{{colors.on_error_container.default.hex}}" }
            },
            // ── PHP — Atributos (#[Route], #[Column]...) ──
            {
                "scope": [
                    "support.attribute.php",
                    "support.attribute.builtin.php"
                ],
                "settings": { "foreground": "{{colors.tertiary.default.hex}}" }
            },
            // ── PHP — Operadores específicos (., ->, ??, ...) ──
            {
                "scope": [
                    "keyword.operator.class.php",
                    "keyword.operator.null-coalescing.php",
                    "keyword.operator.spread.php",
                    "keyword.operator.string.php"
                ],
                "settings": { "foreground": "{{colors.on_surface_variant.default.hex}}" }
            },
            // ── PHP — Namespace e importaciones ──
            {
                "scope": [
                    "keyword.other.namespace.php",
                    "keyword.other.use.php",
                    "support.other.namespace.php",
                    "variable.language.namespace.php"
                ],
                "settings": { "foreground": "{{colors.secondary.default.hex}}" }
            }
        ]
    },

    // ── UI Minimalista ────────────────────────────────────────────
    "workbench.productIconTheme": "fluent-icons",
    "workbench.list.smoothScrolling": true,
    "workbench.navigationControl.enabled": false,
    "workbench.layoutControl.enabled": false,
    "workbench.browser.showInTitleBar": false,
    "window.menuBarVisibility": "compact",
    "workbench.sideBar.location": "right",
    "workbench.iconTheme": "symbols",

    // ── Editor — Tipografía & Cursor ──────────

    "editor.fontFamily": "FiraCode Nerd Font",
    "editor.fontWeight": "500",
    "editor.fontLigatures": true,
    "editor.cursorStyle": "block",
    "editor.cursorBlinking": "expand",
    "editor.cursorSmoothCaretAnimation": "on",


    // ── Editor — Comportamiento general ───────

    "editor.renderWhitespace": "trailing",
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.suggestSelection": "recentlyUsedByPrefix",
    "editor.smoothScrolling": true,
    "editor.inlayHints.enabled": "off",
    "editor.codeActionsOnSave": {
        "source.organizeImports": "explicit"
    },


    // ── Editor — Minimapa ─────────────────────

    "editor.minimap.enabled": false,
    "editor.minimap.autohide": "mouseover",


    // ── Formato de código — Prettier ──────────

    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "prettier.tabWidth": 4,
    "prettier.printWidth": 120,
    "prettier.arrowParens": "avoid",


    // ── Formato de código — Por lenguaje ──────

    "[html]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true
    },
    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true
    },
    "[c]": {
        "editor.defaultFormatter": "ms-vscode.cpptools",
        "editor.formatOnSave": true
    },
    "[cpp]": {
        "editor.defaultFormatter": "ms-vscode.cpptools",
        "editor.formatOnSave": true
    },
    "[php]": {
        "editor.defaultFormatter": "bmewburn.vscode-intelephense-client",
        "editor.formatOnSave": true
    },
    "[python]": {
        "editor.defaultFormatter": "charliermarsh.ruff",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.fixAll.ruff": "explicit",
            "source.organizeImports.ruff": "explicit"
        }
    },


    // ── TypeScript & JavaScript ───────────────

    "js/ts.preferences.importModuleSpecifierEnding": "minimal",
    "js/ts.preferences.preferTypeOnlyAutoImports": true,


    // ── Python (Ruff & Pylance) ───────────────

    "python.languageServer": "Pylance",
    "ruff.nativeServer": "on",
    "ruff.lineLength": 120,


    // ── Qt / QML ──────────────────────────────

    "qt-qml.qmlls.additionalImportPaths": ["/usr/lib/qt6/qml"],
    "qt-qml.qmlls.customExePath": "/usr/bin/qmlls6",
    "qt-qml.doNotAskForQmllsDownload": true,
    "qt-core.additionalQtPaths": [
        {
            "name": "Qt-5.15.18-linux-g++_from_PATH",
            "path": "/usr/bin/qtpaths"
        }
    ],


    // ── Git ───────────────────────────────────

    "git.enableSmartCommit": true,
    "git.autofetch": true,
    "git.confirmSync": false,


    // ── Terminal ──────────────────────────────

    "terminal.integrated.smoothScrolling": true,
    "terminal.integrated.enableMultiLinePasteWarning": "never",


    // ── Explorador de archivos ────────────────

    "explorer.confirmDragAndDrop": false,
    "explorer.confirmDelete": false,


    // ── Diff Editor ───────────────────────────

    "diffEditor.hideUnchangedRegions.enabled": true,


    // ── Extensiones varias ────────────────────

    "liveServer.settings.donotShowInfoMsg": true,
    "auto-close-tag.SublimeText3Mode": false,
    "auto-close-tag.enableAutoCloseTag": true,
    "auto-close-tag.activationOnLanguage": [
        "xml",
        "php",
        "blade",
        "ejs",
        "jinja",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "plaintext",
        "markdown",
        "vue",
        "liquid",
        "erb",
        "lang-cfml",
        "cfml",
        "HTML (Eex)"
    ],

    "emmet.includeLanguages": {
        "php": "html"
    },
    "emmet.triggerExpansionOnTab": true,


    // ── Claude Code ───────────────────────────

    "claudeCode.preferredLocation": "panel",
    "chat.unifiedAgentsBar.enabled": true,


    // ── Asociaciones de archivos ──────────────

    "workbench.editorAssociations": {
        "*.copilotmd": "vscode.markdown.preview.editor",
        "{git,gitlens,chat-editing-snapshot-text-model,copilot,git-graph,git-graph-3}:/**/*.qrc": "default",
        "*.qrc": "qt-core.qrcEditor",
        "*.epub": "default"
    },


    // ── Seguridad del workspace ───────────────

    "security.workspace.trust.startupPrompt": "always",
    "extensions.ignoreRecommendations": true,
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "scminput": false,
        "javascript": false
    },
    "github.copilot.nextEditSuggestions.eagerness": "low",
    "chat.viewSessions.orientation": "stacked",
    "gitlens.ai.model": "vscode",
    "gitlens.ai.vscode.model": "copilot:gpt-4.1",
    "editor.linkedEditing": true

}
