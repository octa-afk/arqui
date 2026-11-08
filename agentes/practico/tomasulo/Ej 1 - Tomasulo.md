# Ejercicio 1 — Simulación Tomasulo (ciclo a ciclo)

> Fuente: `teorico-practico/practico/tomasulo/Ej 1 - Tomasulo.xlsx`. Hojas: `Template` y `clk 1` a `clk 8`.
> **Resolución incompleta**: la planilla termina en el clk 8 con `sub`, `mult`, `div` y `add` todavía en ejecución.
> Las celdas se transcriben tal como aparecen en la hoja. El clk 8 tiene la tabla de estaciones de reserva corrida y su columna `Busy` es inconsistente; no usar esa tabla como fuente confiable.

## Programa

| # | Instrucción |
|---|---|
| 1 | `LDURD D6, [X2, #32]` |
| 2 | `LDURD D2, [X3, #44]` |
| 3 | `FMULD D0, D2, D4` |
| 4 | `FSUBD D8, D2, D6` |
| 5 | `FDIVD D0, D0, D6` |
| 6 | `FADDD D6, D8, D2` |

## Hardware (según la hoja)

- Issue = 1 instrucción por ciclo.
- Load = 6 estaciones de reserva (RS), 1 ciclo.
- Store = 6 RS, 1 ciclo.
- Suma punto flotante = 3 RS, 2 ciclos.
- Multiplicación punto flotante = 2 RS, 6 ciclos.

## Estado de instrucciones por ciclo

Formato de cada celda: `Issue / Execute / Write result`, con `1` = hecho y `0` = pendiente.

| Clk | 1 LDURD | 2 LDURD | 3 FMULD | 4 FSUBD | 5 FDIVD | 6 FADDD |
|---|---|---|---|---|---|---|
| 1 | 1 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 |
| 2 | 1 / 1 / 0 | 1 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 |
| 3 | 1 / 1 / 0 | 1 / 1 / 0 | 1 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 |
| 4 | 1 / 1 / 1 | 1 / 1 / 0 | 1 / 0 / 0 | 1 / 0 / 0 | 0 / 0 / 0 | 0 / 0 / 0 |
| 5 | 1 / 1 / 1 | 1 / 1 / 1 | 1 / 0 / 0 | 1 / 0 / 0 | 1 / 0 / 0 | 0 / 0 / 0 |
| 6 | 1 / 1 / 1 | 1 / 1 / 1 | 1 / 1 / 0 | 1 / 1 / 0 | 1 / 0 / 0 | 1 / 0 / 0 |
| 7 | 1 / 1 / 1 | 1 / 1 / 1 | 1 / 1 / 0 | 1 / 1 / 0 | 1 / 0 / 0 | 1 / 0 / 0 |
| 8 | 1 / 1 / 1 | 1 / 1 / 1 | 1 / 1 / 0 | 1 / 1 / 1 | 1 / 0 / 0 | 1 / 0 / 0 |

## Estaciones de reserva relevantes

- **clk 1**: `load 1` ocupada con `load (1)`, dirección `[X2 + #32]`.
- **clk 3**: `FP mult 1` con `mult (3)`, `Vk = [D4]`, `Qj = load 2`.
- **clk 4**: `FP alu 1` con `sub (4)`, `Vk = [D6]`, `Qj = load 2`.
- **clk 5**: `FP alu 1` con `sub (4)` ya con `Vj = [D2]` y `Vk = [D6]`; `FP mult 1` con `mult (3)`; `FP mult 2` con `div (5)` esperando `FP mult 1`.
- **clk 6**: aparece `FP alu 2` con `add (6)`, esperando `FP alu 1` (`Qj`).

## Estado de registros

En el clk 8 (último de la hoja): `D0 ← FP mult 2`, `D6 ← FP alu 2`, `D8 ← FP alu 1`. El resto sin renombrar.

## Pendiente

- La planilla no calcula los ciclos finales de `sub`, `mult`, `div` y `add`, ni la escritura de `D0`, `D6` y `D8`.
