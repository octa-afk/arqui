# Workshop: Memoria Caché — Arquitectura de Computadoras

Material para el taller práctico de caché usando [RIPES](https://github.com/mortbopet/Ripes) (simulador RISC-V con visualización de caché integrada).

---

## Requisitos

Este repo incluye el código fuente de [RIPES](https://github.com/mortbopet/Ripes) como submódulo git (solo de referencia; no hace falta compilarlo). Al clonar, traerlo con:

```bash
git clone --recurse-submodules <url-de-este-repo>
# o, si ya lo clonaste sin --recurse-submodules:
git submodule update --init --recursive
```

Instalar dependencias y el submódulo con:

```bash
make deps
```

Esto clona/actualiza el submódulo `Ripes/` e instala `gcc-riscv64-unknown-elf` y `yosys` (pide sudo).

**Ejecutable de RIPES:** para correr el simulador no hace falta compilar el submódulo, alcanza con el AppImage precompilado:

```bash
make ripes
```

Esto descarga la última versión del AppImage en `bin/Ripes.AppImage` y configura el compilador C automáticamente. También se puede hacer a mano:

```bash
chmod +x bin/Ripes.AppImage
./bin/Ripes.AppImage
```

y luego:

```bash
chmod +x scripts/setup_compiler.sh
./scripts/setup_compiler.sh
```

Reiniciar RIPES para que tome los cambios.

---

## Contenido

```
labs/practica_ripes.pdf   — Guía completa del taller (30 páginas)
asm/
  ej_array.s              — C[i]=A[i]+B[i] con stride configurable (Assembly)
  ej_conflictos.s         — Conflictos de caché por asociatividad (Assembly)
  ej_localidad.s          — Localidad espacial: stride 1 vs stride 4 (Assembly)
  workshop_array.c        — Array C[i]=A[i]+B[i] (editor C de RIPES)
  stride_test.c           — Test de stride N=128 (editor C de RIPES)
  matrix_row_col.c        — Row-major vs col-major (editor C de RIPES)
  cache_size_test.c       — Working set vs capacidad (editor C de RIPES)
hw/
  cache_comparator.v      — Comparador de caché parametrizable
  cache_top.v             — Wrapper top para síntesis
  plru_state.v            — Lógica de reemplazo PLRU
  tb_cache.v              — Testbench
Ripes/                    — Submódulo git con el código fuente de RIPES (referencia)
scripts/
  setup_compiler.sh       — Configura el compilador C en RIPES
install_deps.sh           — Instala yosys y riscv64-unknown-elf-gcc
```

---

## Cómo usar los archivos `.s`

En RIPES: **File → Load program → seleccionar el `.s`**
Procesador: **Single-Cycle RV32IM**

## Cómo usar los archivos `.c`

En RIPES: abrir la pestaña **Editor**, pegar el contenido del `.c`, compilar con el botón del martillo.
