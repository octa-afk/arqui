# Greencard: Registro, Memoria y Datapath (LEGv8)

## Registro vs Memoria

| | Registro | Memoria (RAM) |
|---|---|---|
| Ubicación | Dentro de la CPU | Fuera de la CPU |
| Cantidad | 32 (X0-X30, XZR) | Millones+ |
| Velocidad | 1 ciclo | Varios ciclos |
| Direccionamiento | Por nombre/número | Por dirección |
| Uso | Datos en uso ahora | Programa y datos grandes |

> Arquitectura **load-store**: la ALU nunca opera directo sobre memoria. Primero `LDUR` (memoria → registro), se opera, y si hace falta `STUR` (registro → memoria).

## Componentes del datapath

- **PC**: dirección de la instrucción actual
- **Memoria de instrucciones**: da la instrucción a partir del PC
- **Banco de registros**: lee hasta 2, escribe 1
- **ALU**: opera o calcula direcciones
- **Memoria de datos**: lee/escribe (solo load/store)
- **Sign-extend**: extiende el inmediato a 64 bits
- **MUX**: eligen la fuente de datos según el tipo de instrucción
- **Sumador de PC**: calcula PC+4 o destino de branch

## Señales de control

| Señal | Qué hace |
|---|---|
| Reg2Loc | Elige de dónde sale el 2do registro a leer |
| ALUSrc | 2do operando de la ALU: registro o inmediato |
| ALUOp | Qué operación hace la ALU |
| MemRead | Habilita lectura de memoria de datos |
| MemWrite | Habilita escritura de memoria de datos |
| MemtoReg | Dato a escribir en registro: ALU o memoria |
| RegWrite | Habilita escritura en banco de registros |
| Branch | Afecta si el PC salta o sigue a PC+4 |

## Tabla por tipo de instrucción

| Instrucción | ALUSrc | MemRead | MemWrite | MemtoReg | RegWrite | Branch |
|---|---|---|---|---|---|---|
| R-type (ADD, SUB...) | 0 | 0 | 0 | 0 | 1 | 0 |
| LDUR | 1 | 1 | 0 | 1 | 1 | 0 |
| STUR | 1 | 0 | 1 | X | 0 | 0 |
| CBZ / branch | 0 | 0 | 0 | X | 0 | 1 |

## Ejemplo: `LDUR X1, [X2, #8]`

1. **Fetch**: PC → memoria de instrucciones → instrucción. PC+4 se calcula en paralelo.
2. **Decode**: se leen Rn=X2 del banco de registros, y el inmediato (8) se sign-extiende.
3. **Execute**: ALU suma `X2 + 8` → dirección de memoria.
4. **Memory**: esa dirección entra a memoria de datos, `MemRead=1` → se lee el dato.
5. **Write-back**: `MemtoReg=1` → el dato leído (no el de la ALU) se escribe en X1.
6. **PC update**: no hay branch → PC = PC+4.

Todo esto ocurre en **un solo ciclo de reloj**.
