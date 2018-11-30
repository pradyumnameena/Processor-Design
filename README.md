# Processor-Design

## Part - 1
### Aim
This assignment aims at designing ARM datapath modules and implementing these on the BASYS3 board. The following subset of ARM instructions has been chosen for implementation.

Arithmetic: <add|sub|rsb|adc|sbc|rsc> {cond} {s}<br/>
Logical: <and | orr | eor | bic> {cond} {s}<br/>
Test: <cmp | cmn | teq | tst> {cond}<br/>
Move: <mov | mvn> {cond} {s}<br/>
Branch: <b | bl> {cond}<br/>
Multiply: <mul | mla> {cond} {s}<br/>
Load/store: <ldr | str> {cond} {b | h | sb | sh }<br/>
cond: <EQ|NE|CS|CC|MI|PL|VS|VC|HI|LS|GE|LT|GT|LE|AL><br/>
<br/>
Instructions excluded are as follows:<br/>
Co-processor: cdp, mcr, mrc, ldc, stc<br/>
Branch and exchange: bx<br/>
Load/Store multiple: ldm, stm<br/>
Software interrupt: swi <br/>
Atomic swap: swp<br/>
PSR transfer: mrs, msr<br/>
Multiply long: mull, mlal<br/>

### Note
Instruction swi will be added later. Following are the building blocks

### ALU
#### Inputs
two 32-bit operands, operation to be performed, carry

#### Outputs
32-bit result of arithmetic/logical operation, next flag values

#### Functionality
It is a combinational circuit that performs the arithmetic/logical operations for the DP instructions. The “operation to be performed” input can come from the opcode field of DP instructions.

Its ability to add/subtract is also used by other instructions by giving appropriate inputs. This includes address offset addition/subtraction for DT and b|bl instructions as well as


  




