#!/usr/bin/env python3
"""Comprueba que los iconos de config.jsonc existen de verdad en la fuente.

Dos fallos que no dan ningún error y solo se ven mirando la barra:

  1. El glifo se pierde al copiar o al pasar por una herramienta que no
     preserva el Private Use Area, y la cadena queda vacía: el icono
     simplemente no se dibuja.
  2. El glifo está escrito pero la fuente no lo trae, y se dibuja el
     rectángulo de "falta glifo" o un icono arbitrario de otra fuente.

    ./test-icons.py            # usa la fuente de style.css
    ./test-icons.py <ruta.ttf> # contra otra fuente
"""
import json
import re
import sys
from pathlib import Path

AQUI = Path(__file__).resolve().parent
FUENTE_POR_DEFECTO = "/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf"

# Claves cuyo valor es texto que se dibuja en la barra.
CLAVES_CON_ICONO = ("format", "format-icons", "window-rewrite", "window-rewrite-default")

# El único icono vacío a propósito: en un workspace ocupado, {icon} se anula
# para dejar sitio a {windows}. Cualquier otro vacío es un glifo que se perdió
# al editar.
VACIOS_INTENCIONALES = {
    "hyprland/workspaces.format-icons.default",
}


def sin_comentarios(texto):
    """JSONC -> JSON. Quita // ... respetando las barras dentro de strings."""
    fuera = []
    for linea in texto.splitlines():
        en_string = False
        escapado = False
        for i, c in enumerate(linea):
            if escapado:
                escapado = False
                continue
            if c == "\\":
                escapado = True
            elif c == '"':
                en_string = not en_string
            elif c == "/" and not en_string and linea[i : i + 2] == "//":
                linea = linea[:i]
                break
        fuera.append(linea)
    return "\n".join(fuera)


def recolectar(nodo, ruta=""):
    """Devuelve (ruta, valor) de cada cadena bajo una clave de icono."""
    salida = []
    if isinstance(nodo, dict):
        for k, v in nodo.items():
            sub = f"{ruta}.{k}" if ruta else k
            if k in CLAVES_CON_ICONO:
                salida += [(p, s) for p, s in recolectar(v, sub)] if not isinstance(v, str) else [(sub, v)]
            else:
                salida += recolectar(v, sub)
    elif isinstance(nodo, list):
        for i, v in enumerate(nodo):
            salida += recolectar(v, f"{ruta}[{i}]")
    elif isinstance(nodo, str) and ruta:
        salida.append((ruta, nodo))
    return salida


def main():
    ruta_fuente = Path(sys.argv[1] if len(sys.argv) > 1 else FUENTE_POR_DEFECTO)
    if not ruta_fuente.exists():
        print(f"no encuentro la fuente: {ruta_fuente}", file=sys.stderr)
        return 1

    from fontTools.ttLib import TTFont

    fuente = TTFont(ruta_fuente, lazy=True)
    cmap = {}
    for tabla in fuente["cmap"].tables:
        cmap.update(tabla.cmap)

    config = json.loads(sin_comentarios((AQUI / "config.jsonc").read_text()))
    entradas = recolectar(config)

    vacios, faltantes, ok = [], [], 0

    for ruta, valor in entradas:
        # Un format puede ser solo texto ("{short}", "{:%I:%M %p}"): no exige icono.
        glifos = [c for c in valor if ord(c) >= 0x2000]

        # Los format-icons y window-rewrite existen para dibujar un icono; si el
        # valor no tiene ninguno y tampoco es un placeholder, se perdió.
        es_solo_icono = ".format-icons." in ruta or ".window-rewrite" in ruta
        if es_solo_icono and not glifos and "{" not in valor:
            if ruta not in VACIOS_INTENCIONALES:
                vacios.append(ruta)
            continue

        for c in glifos:
            if ord(c) in cmap:
                ok += 1
            else:
                faltantes.append((ruta, c))

    for ruta in vacios:
        print(f"VACÍO     {ruta}  (se perdió el glifo)", file=sys.stderr)
    for ruta, c in faltantes:
        print(f"SIN GLIFO {ruta}  U+{ord(c):05X}", file=sys.stderr)

    if vacios or faltantes:
        return 1

    print(f"ok  {ok} glifos verificados en {ruta_fuente.name}, {len(entradas)} cadenas revisadas")
    return 0


if __name__ == "__main__":
    sys.exit(main())
