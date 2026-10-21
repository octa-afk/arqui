# Organización de Memorias CACHE

> Conversión fiel a Markdown del PDF/PPTX `OrganizacionMemoriasCACHE.pptx.pdf` (54 diapositivas).
> Basado en el Capítulo 5 de *Computer Organization and Design - ARM Edition* (Patterson & Hennessy), adaptado para la cátedra de Arquitectura de Computadoras.

---

## Diapositiva 1: COMPUTER ORGANIZATION AND                                ARM

Edition
The Hardware/Software Interface
DESIGN
Chapter 5
Large and Fast:
Exploiting Memory
Hierarchy
Adapted version!
Dr. Agustin M. Laprovitta (alaprovitta@unc.edu.ar)
Ing. Gonzalo Vodanovic (gvodanovic@unc.edu.ar)
Dr. Valentín Basel ( valentinbasel@unc.edu.ar)

---

## Diapositiva 2: §5.2 Memory Technologies - Memory Technology

- Static RAM (SRAM)
- 0.5ns – 2.5ns, $2000 – $5000 per GB
- Dynamic RAM (DRAM)
- 50ns – 70ns, $20 – $75 per GB
- Magnetic disk
- 5ms – 20ms, $0.20 – $2 per GB
- Ideal memory
- Access time of SRAM
- Capacity and cost/GB of disk

---

## Diapositiva 3: §5.1 Introduction - Principle of Locality

- Programs access a small proportion of
their address space at any time
- Temporal locality
- Items accessed recently are likely to be
accessed again soon
- e.g., instructions in a loop, induction variables
- Spatial locality
- Items near those accessed recently are likely
to be accessed soon
- E.g., sequential instruction access, array data

---

## Diapositiva 4: Taking Advantage of Locality

- Memory hierarchy
- Store everything on disk
- Copy recently accessed (and nearby) items
from lower levels to higher levels

---

## Diapositiva 5: Memory Hierarchy Levels

- Block (aka line): unit of copying
- May be multiple words
- If accessed data is present in
upper level
- Hit: access satisfied by upper level
- Hit ratio: hits/accesses
- If accessed data is absent
- Miss: block copied from lower level
- Time taken: miss penalty
- Miss ratio: misses/accesses
= 1 – hit ratio
- Then accessed data supplied from
upper level

---

## Diapositiva 6: Cache organization


---

## Diapositiva 7: Interface Signals

Read/Write                          Read/Write
Valid                               Valid
32                                    32
Address                             Address
32      Cache                        128     Memory
CPU   Write Data                          Write Data
32                                   128
Read Data                           Read Data
Ready                               Ready
Multiple cycles
per access

---

## Diapositiva 8: §5.3 The Basics of Caches - Cache Memory

- Cache memory
- The level of the memory hierarchy closest to
the CPU
- Given accesses X1, …, Xn–1, Xn
- How do we know if
the data is present?
- Where do we look?

---

## Diapositiva 9: Cache Memory


---

## Diapositiva 10: Tags and Valid Bits

- How do we know which particular block is
stored in a cache location?
- Store block address as well as the data
- Actually, only need the high-order bits
- Called the tag
- What if there is no data in a location?
- Valid bit: 1 = present, 0 = not present
- Initially 0

---

## Diapositiva 11: Cache Misses

- On cache hit, CPU proceeds normally
- On cache miss
- Stall the CPU pipeline
- Fetch block from next level of hierarchy
- Instruction cache miss
- Restart instruction fetch
- Data cache miss
- Complete data access

---

## Diapositiva 12: Direct Mapped Cache

- Location determined by address
- Direct mapped: only one choice
- (Block address) modulo (#Blocks in cache)
- #Blocks is a
power of 2
- Use low-order
address bits

---

## Diapositiva 13: Direct Mapped Cache - Address Subdivision


---

## Diapositiva 14: Direct Mapped Cache - example


---

## Diapositiva 15: Cache Example

- 8-blocks, 1 word/block, direct mapped
- Initial state
Index   V   Tag        Data
000     N
001     N
010     N
011     N
100     N
101     N
110     N
111     N

---

## Diapositiva 16: Cache Example

Word addr       Binary addr          Hit/miss   Cache block
22            10 110           Miss         110
Index        V   Tag           Data
000          N
001          N
010          N
011          N
100          N
101          N
110          Y   10            Mem[10110]
111          N

---

## Diapositiva 17: Cache Example

Word addr       Binary addr          Hit/miss   Cache block
26            11 010           Miss         010
Index        V   Tag           Data
000          N
001          N
010          Y   11            Mem[11010]
011          N
100          N
101          N
110          Y   10            Mem[10110]
111          N

---

## Diapositiva 18: Cache Example

Word addr       Binary addr          Hit/miss   Cache block
22            10 110            Hit         110
26            11 010            Hit         010
Index        V   Tag           Data
000          N
001          N
010          Y   11            Mem[11010]
011          N
100          N
101          N
110          Y   10            Mem[10110]
111          N

---

## Diapositiva 19: Cache Example

Word addr       Binary addr          Hit/miss   Cache block
16            10 000           Miss         000
3             00 011           Miss         011
16            10 000            Hit         000
Index        V   Tag           Data
000          Y   10            Mem[10000]
001          N
010          Y   11            Mem[11010]
011          Y   00            Mem[00011]
100          N
101          N
110          Y   10            Mem[10110]
111          N

---

## Diapositiva 20: Cache Example

Word addr       Binary addr          Hit/miss   Cache block
18            10 010           Miss         010
Index        V   Tag           Data
000          Y   10            Mem[10000]
001          N
010          Y   10            Mem[10010]
011          Y   00            Mem[00011]
100          N
101          N
110          Y   10            Mem[10110]
111          N

---

## Diapositiva 21: Associative Caches

- Fully associative
- Allow a given block to go in any cache entry
- Requires all entries to be searched at once
- Comparator per entry (expensive)
- n-way set associative
- Each set contains n entries
- Block number determines which set
- (Block number) modulo (#Sets in cache)
- Search all entries in a given set at once
- n comparators (less expensive)

---

## Diapositiva 22: Spectrum of Associativity

- For a cache with 8 entries

---

## Diapositiva 23: Associative Cache Example


---

## Diapositiva 24: Fully Associative Cache - Address Subdivision


---

## Diapositiva 25: Fully Associative Cache - example


---

## Diapositiva 26: k-way Set Associative Cache - Address Subdivision


---

## Diapositiva 27: Set Associative Cache - example


---

## Diapositiva 28: Set Associative Cache Organization


---

## Diapositiva 29: Associativity Example

- Compare 4-block caches
- Direct mapped, 2-way set associative,
fully associative
- Block access sequence: 0, 8, 0, 6, 8
- Direct mapped
Block    Cache   Hit/miss            Cache content after access
address   index                0           1             2         3
0        0      miss      Mem[0]
8         0      miss      Mem[8]
0         0      miss      Mem[0]
6         2      miss      Mem[0]                  Mem[6]
8         0      miss      Mem[8]                  Mem[6]

---

## Diapositiva 30: Associativity Example

- 2-way set associative
Block    Cache   Hit/miss          Cache content after access
address   index                    Set 0                   Set 1
0        0      miss      Mem[0]
8         0      miss      Mem[0]      Mem[8]
0         0       hit      Mem[0]      Mem[8]
6         0      miss      Mem[0]      Mem[6]
8         0      miss      Mem[8]      Mem[6]
- Fully associative
Block            Hit/miss            Cache content after access
address
0               miss      Mem[0]
8                miss      Mem[0]      Mem[8]
0                 hit      Mem[0]      Mem[8]
6                miss      Mem[0]      Mem[8]      Mem[6]
8                 hit      Mem[0]      Mem[8]      Mem[6]

---

## Diapositiva 31: How Much Associativity

- Increased associativity decreases miss
rate
- But with diminishing returns
- Simulation of a system with 64KB
D-cache, 16-word blocks, SPEC2000
- 1-way: 10.3%
- 2-way: 8.6%
- 4-way: 8.3%
- 8-way: 8.1%

---

## Diapositiva 32: Example: Direct Mapped Cache


---

## Diapositiva 33: §5.8 A Common Framework for Memory Hierarchies - The Memory Hierarchy

The BIG
Picture
- Common principles apply at all levels of
the memory hierarchy
- Based on notions of caching
- At each level in the hierarchy
- Block placement
- Finding a block
- Replacement on a miss
- Write policy

---

## Diapositiva 34: Block Size Considerations

- Larger blocks should reduce miss rate
- Due to spatial locality
- But in a fixed-sized cache
- Larger blocks ⇒ fewer of them
- More competition ⇒ increased miss rate
- Larger blocks ⇒ pollution
- Larger miss penalty
- Can override benefit of reduced miss rate
- Early restart and critical-word-first can help

---

## Diapositiva 35: Block Placement

- Determined by associativity
- Direct mapped (1-way associative)
- One choice for placement
- n-way set associative
- n choices within a set
- Fully associative
- Any location
- Higher associativity reduces miss rate
- Increases complexity, cost, and access time

---

## Diapositiva 36: Finding a Block

Associativity        Location method                 Tag comparisons
Direct mapped        Index                           1
n-way set            Set index, then search          n
associative          entries within the set
Fully associative    Search all entries              #entries
Full lookup table               0

---

## Diapositiva 37: Sources of Misses

- Compulsory misses (aka cold start misses)
- First access to a block
- Capacity misses
- Due to finite cache size
- A replaced block is later accessed again
- Conflict misses (aka collision misses)
- In a non-fully associative cache
- Due to competition for entries in a set
- Would not occur in a fully associative cache of
the same total size

---

## Diapositiva 38: Replacement Policy

- Direct mapped: no choice
- Set associative
- Prefer non-valid entry, if there is one
- Otherwise, choose among entries in the set
- Least-recently used (LRU)
- Choose the one unused for the longest time
- Simple for 2-way, manageable for 4-way, too hard
beyond that
- Random
- Gives approximately the same performance as
LRU for high associativity

---

## Diapositiva 39: Write Allocation

- What should happen on a write miss?
- Alternatives for write-through
- Allocate on miss: fetch the block
- Write around: don’t fetch the block
- Since programs often write a whole block before
reading it (e.g., initialization)
- For write-back
- Usually fetch the block

---

## Diapositiva 40: Write-Through

- On data-write hit, could just update the block in
cache
- But then cache and memory would be inconsistent
- Write through: also update memory
- But makes writes take longer
- e.g., if base CPI = 1, 10% of instructions are stores,
write to memory takes 100 cycles
- Effective CPI = 1 + 0.1×100 = 11
- Solution: write buffer
- Holds data waiting to be written to memory
- CPU continues immediately
- Only stalls on write if write buffer is already full

---

## Diapositiva 41: Write-Back

- Alternative: On data-write hit, just update
the block in cache
- Keep track of whether each block is dirty
- When a dirty block is replaced
- Write it back to memory
- Can use a write buffer to allow replacing block
to be read first

---

## Diapositiva 42: §5.4 Measuring and Improving Cache Performance - Measuring Cache Performance

- Components of CPU time
- Program execution cycles
- Includes cache hit time
- Memory stall cycles
- Mainly from cache misses
- With simplifying assumptions:

---

## Diapositiva 43: Cache Performance Example

- Given
- I-cache miss rate = 2%
- D-cache miss rate = 4%
- Miss penalty = 100 cycles
- Base CPI (ideal cache) = 2
- Load & stores are 36% of instructions
- Miss cycles per instruction
- I-cache: 0.02 × 100 = 2
- D-cache: 0.36 × 0.04 × 100 = 1.44
- Actual CPI = 2 + 2 + 1.44 = 5.44
- Ideal CPU is 5.44/2 =2.72 times faster

---

## Diapositiva 44: Average Access Time

- Hit time is also important for performance
- Average memory access time (AMAT)
- AMAT = Hit time + Miss rate × Miss penalty
- Example
- CPU with 1ns clock, hit time = 1 cycle, miss
penalty = 20 cycles, I-cache miss rate = 5%
- AMAT = 1 + 0.05 × 20 = 2ns
- 2 cycles per instruction

---

## Diapositiva 45: Multilevel Caches

- Primary cache attached to CPU
- Small, but fast
- Level-2 cache services misses from
primary cache
- Larger, slower, but still faster than main
memory
- Main memory services L-2 cache misses
- Some high-end systems include L-3 cache

---

## Diapositiva 46: Multilevel Cache Example

- Given
- CPU base CPI = 1, clock rate = 4GHz
- Miss rate/instruction = 2%
- Main memory access time = 100ns
- With just primary cache
- Miss penalty = 100ns/0.25ns = 400 cycles
- Effective CPI = 1 + 0.02 × 400 = 9

---

## Diapositiva 47: Example (cont.)

- Now add L-2 cache
- Access time = 5ns
- Global miss rate to main memory = 0.5%
- Primary miss with L-2 hit
- Penalty = 5ns/0.25ns = 20 cycles
- Primary miss with L-2 miss
- Extra penalty = 500 cycles
- CPI = 1 + 0.02 × 20 + 0.005 × 400 = 3.4
- Performance ratio = 9/3.4 = 2.6

---

## Diapositiva 48: Multilevel Cache Considerations

- Primary cache
- Focus on minimal hit time
- L-2 cache
- Focus on low miss rate to avoid main memory
access
- Hit time has less overall impact
- Results
- L-1 cache usually smaller than a single cache
- L-1 block size smaller than L-2 block size

---

## Diapositiva 49: Interactions with Advanced CPUs

- Out-of-order CPUs can execute
instructions during cache miss
- Pending store stays in load/store unit
- Dependent instructions wait in reservation
stations
- Independent instructions continue
- Effect of miss depends on program data
flow
- Much harder to analyse
- Use system simulation

---

## Diapositiva 50: Cache Design Trade-offs

Design change            Effect on miss rate           Negative performance
effect
Increase cache size      Decrease capacity             May increase access
misses                        time
Increase associativity   Decrease conflict             May increase access
misses                        time
Increase block size      Decrease compulsory           Increases miss
misses                        penalty. For very large
block size, may
increase miss rate
due to pollution.

---

## Diapositiva 51: §5.15 Fallacies and Pitfalls - Pitfalls

- Byte vs. word addressing
- Example: 32-byte direct-mapped cache,
4-byte blocks
- Byte 36 maps to block 1
- Word 36 maps to block 4
- Ignoring memory system effects when
writing or generating code
- Example: iterating over rows vs. columns of
arrays
- Large strides result in poor locality

---

## Diapositiva 52: Pitfalls

- In multiprocessor with shared L2 or L3
cache
- Less associativity than cores results in conflict
misses
- More cores ⇒ need to increase associativity
- Using AMAT to evaluate performance of
out-of-order processors
- Ignores effect of non-blocked accesses
- Instead, evaluate performance by simulation

---

## Diapositiva 53: Pitfalls

- Extending address range using segments
- E.g., Intel 80286
- But a segment is not always big enough
- Makes address arithmetic complicated
- Implementing a VMM on an ISA not
designed for virtualization
- E.g., non-privileged instructions accessing
hardware resources
- Either extend ISA, or require guest OS not to
use problematic instructions

---

## Diapositiva 54: §5.16 Concluding Remarks - Concluding Remarks

- Fast memories are small, large memories are
slow
- We really want fast, large memories ☹
- Caching gives this illusion ☺
- Principle of locality
- Programs use a small part of their memory space
frequently
- Memory hierarchy
- L1 cache ↔ L2 cache ↔ … ↔ DRAM memory
↔ disk
- Memory system design is critical for
multiprocessors

---
