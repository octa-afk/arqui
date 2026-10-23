#!/usr/bin/env bash
# =============================================================================
# setup_compiler.sh — Configura el compilador C en RIPES
#
# Aplica tres claves en ~/.config/Ripes/Ripes.conf:
#   compiler_path  = /usr/bin/riscv64-unknown-elf-gcc
#   compiler_args  = -O1
#   linker_args    = -nostdlib -nostartfiles
#
# Uso:
#   chmod +x setup_compiler.sh && ./setup_compiler.sh
#
# Por que estas opciones:
#   - /usr/bin/riscv64-unknown-elf-gcc es el unico que tiene multilib rv32im/ilp32
#   - RIPES ya agrega -march=rv32im -mabi=ilp32 automaticamente; no repetirlos
#   - -nostdlib -nostartfiles evita buscar newlib (no instalada para rv32);
#     RIPES no necesita libc: arranca directamente desde main()
# =============================================================================

set -e

CONF="$HOME/.config/Ripes/Ripes.conf"

# Verificar que RIPES ya fue ejecutado al menos una vez
if [ ! -f "$CONF" ]; then
    echo "ERROR: No se encontro $CONF"
    echo "  Abrir RIPES al menos una vez antes de ejecutar este script."
    exit 1
fi

# Verificar que el compilador existe
COMPILER="/usr/bin/riscv64-unknown-elf-gcc"
if [ ! -x "$COMPILER" ]; then
    echo "ERROR: No se encontro $COMPILER"
    echo "  Instalar con: sudo apt install gcc-riscv64-unknown-elf"
    exit 1
fi

echo "Configurando compilador C en RIPES..."
echo "  Conf: $CONF"
echo "  Compilador: $COMPILER"

# Actualizar o agregar cada clave en el archivo de configuracion
set_key() {
    local key="$1"
    local val="$2"
    if grep -q "^${key}=" "$CONF"; then
        sed -i "s|^${key}=.*|${key}=${val}|" "$CONF"
    else
        echo "${key}=${val}" >> "$CONF"
    fi
}

set_key "compiler_path" "/usr/bin/riscv64-unknown-elf-gcc"
set_key "compiler_args" "-O1"
set_key "linker_args"   "-nostdlib -nostartfiles"

echo ""
echo "Listo. Verificacion:"
grep -E "^compiler_|^linker_" "$CONF"
echo ""
echo "Reiniciar RIPES para que tome los cambios."
