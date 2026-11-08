# arqui — material de Arquitectura de Computadoras (FAMAF 2026)

Carpeta con el material de la materia: teóricos, prácticos, parciales, notas y el taller de caché.

## Cómo está organizado

| Carpeta | Qué es | Para qué |
|---|---|---|
| `teorico-practico/` | Fuentes originales (PDF, xlsx, ods, notas de Obsidian) | Material original. Solo lectura. |
| `parciales_viejos/` | Parciales originales en PDF | Solo lectura. |
| `agentes/` | Versiones en Markdown de las fuentes, para agentes de IA | Lectura por agentes. Empezar por `agentes/INDEX.md`. |
| `agentes/resumenes/` y `agentes/ejercicios/` | Material derivado, no es de la cátedra | Ver aviso abajo. |
| `.atl/` | Configuración de herramientas | No es material de estudio. |

La regla es simple: cada archivo de `teorico-practico/` o `parciales_viejos/` tiene su equivalente en `agentes/`, con el mismo nombre base y en la carpeta espejo.

## Aviso importante

- **`agentes/ejercicios/` fue generado por un agente de IA**, no es material de la cátedra. Verificar cualquier dato contra el PDF original antes de usarlo.
- **`agentes/resumenes/resumen_parcial2_completo.md`** es un resumen hecho a partir de teóricos y parciales. Lo marcado **[ext]** no está en los apuntes.
- Las conversiones a Markdown se hicieron a mano o con IA. Si un dato es crítico, contrastarlo con el PDF.

## Dónde buscar

- **Teóricos y prácticos:** `teorico-practico/teorico/` y `teorico-practico/practico/`.
- **Parciales:** `parciales_viejos/`.
- **Tomasulo (planillas):** `teorico-practico/practico/tomasulo/`.
- **Notas propias:** `teorico-practico/notas/`.
- **Taller de caché con RIPES:** `teorico-practico/practico/2026-cache_ripes_hardware-main-1/`.

El índice completo de qué Markdown corresponde a qué fuente está en `agentes/INDEX.md`.

## Pendiente

- La carpeta del taller de RIPES tiene doble nivel (`2026-cache_ripes_hardware-main-1/2026-cache_ripes_hardware-main/`). Decidir si se aplana.
- Los cambios de reorganización (archivos movidos o borrados) todavía no están commiteados.
