# IITK-Mini-MIPS-CS220-Course-Project


## Problem Statement: 

We want to create a new processor IITK-Mini-MIPS that has the instruction set architecture as shown in Tab.1 below. We assume that the processor word size and instruction size are 32 bits. The processor has two different memories: a) Instruction Memory (for storing instructions), b) Data Memory (for storing data). You have to make sure that these two sections do not overlap. We also assume that IITKMini-MIPS has a total of 32 general purpose registers and 32 floating point registers, of which certain registers follow the same roles as in MIPS-32 ISA. For example, Program Counter (PC) register holds the address of the next instruction. Note that movement from floating point registers to general purpose registers is only allowed through mf c1 and mtc1 instruction.

The target is to create the op-code formats for the given ISA, shown in Table 1, decide upon the data path elements (such as addition, subtraction, shift, jump) and then develop different verilog modules for the same along with the finite state machine for the control path. Finally we shall build a single-cycle instruction execution unit for IITK-MIni-MIPS.

## Processor Development Strategy:

Now to do the project, we shall follow the below-mentioned steps and every step should be documented in the project report:
1. [PDS1] Decide the registers and their usage protocol.
2. [PDS2] Decide upon the size for instruction and data memory.
3. [PDS3] Design the instruction layout for R-, I- and J-type instructions and their respective encoding methodologies.
4. [PDS4] Now design and implement an instruction fetch phase where the instruction next to be executed will be stored in the instruction register.
5. [PDS5] Next, design and implement a module for instruction decode to identify which data path element to execute given the opcode of the instruction.
6. [PDS6] Design and implement the Arithmetic Logic Unit (ALU) in top-down approach to develop different modules for different types of instructions. There might be some hardware parts in the ALU that can be shared by different modules if required. This will reduce the footprint of the hardware.
7. [PDS7] Design and implement the branching operation along the ALU implementation.
8. [PDS8] Design the finite state machine for the control signals to execute the processor. Please ensure that every instruction should be executed in single clock cycle. Finally write the test benches to simulate the IITK-Mini-MIPS.
9. [PDS9] Develop the MIPS code for Bucket Sort. Then convert it into machine code following the ISA given above.
10. [PDS10] Store the machine code in the instruction memory and execute IITK-Mini-MIPS. Store the output of the bucket sort in the data memory.
