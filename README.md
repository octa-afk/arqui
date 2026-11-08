# arqui — material de Arquitectura de Computadoras (FAMAF 2026)

Carpeta con el material de la materia: teóricos, prácticos, parciales, recursos y el taller de caché.

## Cómo está organizado

| Carpeta | Qué es | Para qué |
|---|---|---|
| `humanos/teorico/` | Teóricos originales (PDF) | Solo lectura. |
| `humanos/practico/` | Prácticos, planillas Tomasulo y taller de caché (PDF, xlsx, ods) | Solo lectura. |
| `humanos/parciales_viejos/` | Parciales originales en PDF | Solo lectura. |
| `humanos/recursos/` | Referencias y plantillas (Datapath Greencard en Markdown, plantilla Tomasulo en ods) | Espejo en `agentes/recursos/`. |
| `agentes/` | Versiones en Markdown de las fuentes, para agentes de IA | Lectura por agentes. Empezar por `agentes/INDEX.md`. |
| `.atl/` | Configuración de herramientas | No es material de estudio. |

La regla es simple: cada archivo de `humanos/teorico/`, `humanos/practico/`, `humanos/parciales_viejos/` y `humanos/recursos/` tienen su equivalente en `agentes/`, con el mismo nombre base y en la carpeta espejo. Excepción: el taller de RIPES (`humanos/practico/2026-cache_ripes_hardware-main-1/`), que no tiene espejo.

## Aviso importante

- Las conversiones a Markdown se hicieron a mano o con IA. Si un dato es crítico, contrastarlo con el PDF.

## Dónde buscar

- **Teóricos y prácticos:** `humanos/teorico/` y `humanos/practico/`.
- **Parciales:** `humanos/parciales_viejos/`.
- **Tomasulo (planillas):** `humanos/practico/tomasulo/`.
- **Referencias y plantillas:** `humanos/recursos/`.
- **Taller de caché con RIPES:** `humanos/practico/2026-cache_ripes_hardware-main-1/`.

El índice completo de qué Markdown corresponde a qué fuente está en `agentes/INDEX.md`.

## Pendiente

- La carpeta del taller de RIPES tiene doble nivel (`2026-cache_ripes_hardware-main-1/2026-cache_ripes_hardware-main/`). Decidir si se aplana.
- Los cambios de reorganización (archivos movidos o borrados) todavía no están commiteados.
