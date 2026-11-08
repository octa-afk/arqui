# Ejercicio 2 — Tomasulo (clase), enunciado sin resolver

> Fuente: `teorico-practico/practico/tomasulo/Ej 2- Tomasulo - Clase.xlsx`. Una sola hoja, `Template`.
> La planilla tiene el programa y el hardware, pero **las tablas de ciclos y estaciones de reserva están vacías**: es el enunciado para resolver en clase.

## Programa

| # | Instrucción |
|---|---|
| 1 | `LDURD D0, [X1, #0]` |
| 2 | `FMULD D4, D0, D2` |
| 3 | `STURD D4, [X1, #0]` |
| 4 | `SUBI X1, X1, #8` |
| 5 | `CBNZ X1, L` |

## Hardware (según la hoja)

- Issue = 2 instrucciones por ciclo.
- Load = 6 RS, 1 ciclo.
- Store = 6 RS, 1 ciclo.
- ALU entera = 3 RS, 1 ciclo.
- ALU punto flotante = 3 RS, 2 ciclos.
- Multiplicación punto flotante = 2 RS, 3 ciclos.
- Nota de la hoja: el salto `CBNZ` se predice correctamente como *taken*.

## Pendiente

- Completar la tabla de estado de instrucciones (Issue / Execute / Write result) por ciclo.
- Completar las estaciones de reserva y el estado de registros.
