#!/usr/bin/env bash
# install_deps.sh — Instala dependencias para el workshop de caché
#
# Requiere: Debian/Ubuntu, permisos de root (sudo ./install_deps.sh)
#
# Instala:
#   gcc-riscv64-unknown-elf  — compilador RISC-V para RIPES
#   yosys                    — síntesis RTL (ejercicios de hardware)

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: ejecutar con sudo: sudo ./install_deps.sh"
    exit 1
fi

echo "Actualizando lista de paquetes..."
apt-get update -q

echo "Instalando gcc-riscv64-unknown-elf..."
apt-get install -y gcc-riscv64-unknown-elf

echo "Instalando yosys..."
apt-get install -y yosys

echo ""
echo "Verificacion:"
riscv64-unknown-elf-gcc --version | head -1
yosys --version

echo ""
echo "Listo. Ahora ejecutar: ./Ripes/setup_compiler.sh"
