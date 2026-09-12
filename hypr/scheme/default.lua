-- Colores por defecto (fallback antes de que Matugen genere la paleta).
-- hyprland.lua copia este archivo a current.lua si current.lua no existe.
-- Matugen sobreescribe current.lua con los colores del wallpaper.
--
-- Los hex van SIN '#': se concatenan con el alfa en variables.lua,
-- p. ej. "rgba(" .. scheme.primary .. "e6)".

return {
    primary              = "6750A4",
    onPrimary            = "FFFFFF",
    primaryContainer     = "EADDFF",
    onPrimaryContainer   = "21005D",

    secondary            = "625B71",
    onSecondary          = "FFFFFF",
    secondaryContainer   = "E8DEF8",
    onSecondaryContainer = "1D192B",

    tertiary             = "7D5260",
    onTertiary           = "FFFFFF",
    tertiaryContainer    = "FFD8E4",
    onTertiaryContainer  = "31111D",

    error                = "B3261E",
    onError              = "FFFFFF",
    errorContainer       = "F9DEDC",
    onErrorContainer     = "410E0B",

    background           = "1C1B1F",
    onBackground         = "E6E1E5",
    surface              = "1C1B1F",
    onSurface            = "E6E1E5",
    surfaceVariant       = "49454F",
    onSurfaceVariant     = "CAC4D0",
    outline              = "938F99",
    outlineVariant       = "49454F",

    surfaceContainer     = "211F26",
    surfaceContainerHigh = "2B2930",
    surfaceContainerLow  = "1D1B20",

    inverseSurface       = "E6E1E5",
    inverseOnSurface     = "313033",
    inversePrimary       = "6750A4",
}
