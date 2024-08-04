### Coding Challenge Guidelines
Using Vivado 2022.2 (Vivado is free for some devices such as the one used here) create the following envronment:

Create a new project targeting the xcku5p-ffvd900-2L-e that contains the following elements:

1. A differential clock input of 33.33 MHz to drive the custom RTL at 100MHz.
2. A Microblaze Microprocessor.
3. A DDR4 memory interface (default settings are fine).
4. A Custom RTL module that contains an FSM for driving 8 LEDs whose function are determined by the status of an input push button which cycles through
   4 different flashing modes.
5. AXI Debug on the processor bus.
6. Debug on the FSM and counters within the custom rtl core.
7. Constraints for clock, pin I/O locations and any other relevant constraints.

The Memory should be connected to the microprocessor and microprocessor defaults are acceptable for the configuration.

Your design should complete the build process and produce a bitfile and debug file.

You should then archive your project and push the archive file to this code repository for review.

Note: there are 2 clock domains within the design but these are distinct (the memory & processor domain and the custom RTL domain) and should not be connected in any manner.

CDC & creating a custom AXI4 memory mapped register would be too time consuming for a take home task.

### Evaluation Criteria

The successful generation of the project being set up and completing the build process.
Other areas of evaluation will be in code input, appropriate level of comments, sensible design entry and resolution of any critical warnings.

### Useful Links
Vivado 2022.2 download
https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html

Please organize, design, test, and document your code as if it were
going into production - then push your changes to the master branch.

Have fun coding! 🚀