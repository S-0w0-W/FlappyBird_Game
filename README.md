# FlappyBird_Game
 
## About

The aim of this project was to combine synthesisable VHDL components and create a game based on Flappy Bird through the use of FPGAs. The specific FPGA used for this project was the Cyclone III EP3C16F484. Our project uses a data-dominated Processor Architecture i.e. has a relatively simple control unit with a more complex and extensive datapath. Our design consists of four main sections. These sections are: the Graphics section which controls the output to the VGA display, the Text & Menus section which deals with text generation and menu selection, the Physics section which deals with the motion of the bird and pipes, along with collision detection, and finally the Control Unit that derives states from our FSM. This design resulted in a satisfactorily working game. However, there are improvements that can be made in our design, as discussed in this report. Key improvements discussed in this report include: better LFSR implementations for Pipe randomisation, accurate clock division for smoother Bird Physics, the utilisation of the built-in memory such as the FLASH or SRAM memory to have a more complex and resource-efficient visuals, simplification of external controls to use just one input device, as well as  displaying scores and levels on-screen.

## Usage

All nessasary files that are needed are contained within the "*resources*" folder, these include all the VHD files that can then be converted into symbol files.

Here the VHD files has already been processed for you and can all be found in the "*symbol_files*" folder. 

The game itself is then made by connecting the components available, a completed schematic diagram (.bdf) can be found also in the "*resources*" folder called "*Flappy-Grades*".

Finally this can then all be compiled on Quartus (specific version used is: Quartus II 64-bit).

However if simply wish to run the result of the game then a *.sof* is also provided which can be directly uploaded into the FPGA through Quartus. (FPGA used for this project is the *Cyclone III ep3c16f484c6*).
