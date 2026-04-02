/*******************************************************************
File: README.TXT
Version:        1.7
Purpose: To Explain how to use the reference implementation code.
         How to compile and how to run.
*******************************************************************/
This file contains information that is useful to compile the
software for the reference implementation and test it.

What is needed?
===============
  You need a version of gnu "make" pgm that runs on PC. A pre-compiled
  version (make.exe) is provided in this directory. Place it in
  your executable path or leave it in the current dir.

  You need the SDS compiler, assembler, and linker.

Description of Files
====================
readme.txt          	This file.
LICENSE.txt             ANSI/EIA 709.1-A-1999 Example Code Software License Agreement
Refimp-final_1.7.pdf 	Complete documentation for reference implementation.
Makefile        	Script file for make utility
eia709_1.h      	Constants and Type Definitions that are commonly
                	used by reference implementation.
node.h          	Type defintions for globals, variable decls,
                	function prototypes (that are not specific to 
                	any layer). Includes api.h.
                	Most application programs can include this file.
node.c          	Global Variables and Code for functions in node.h
custom.h        	User editable header file to define constants.
custom.c        	User editable values that are not in custom.h
                	(Needed to support multiple stacks)
api.h           	Interface file for application program. Also used
                	by some .c files in the ref. impl.
app.c[h]        	Application Layer Code (C file and Header File)
netmgmt.c[h]    	Network Management and Diagnostics code.
tsa.c[h]        	Transport/Session/Authentication Code
tcs.c[h]        	Transaction Control Sublayer
network.c[h]    	Network Layer
link.c[h]       	Link Layer
physical.c[h]   	Physical Layer
spm.c           	Interrupt Driven Code for handling special purpose
                	mode. Has the channel access algorithm too.
                	Has a function to handle buttons and LEDs.
direct.c        	Interrupt Driven Code for handling direct mode.
                	(if it exists)
eeprom.c        	Data Structures that are placed in EEPROM (eventually).
queue.c[h]              Queue Functions that are used to access various 
                        queues. Queue is implemented as a circular array.
stktimer.c[h]           Hardware timer code needed for handling timeouts.
main.c                  Scheduler for the ref. impl. 
start.s                 Assembly program that calls main.
                        (Used in SDS setup)
apppgm.c                The Application program itself. No .h file.
                        There are various example files. Copy the one
                        needed into this file before compiling.
                        The subdir testpgms sample programs that were
                        used to test the ref imp.
refimp.spc              Linker Specification File. Specifies how to load code
                        into 68360 RAM.
refimp.out              Final Linked Loadable Image. The size does not reflect
                        what is actually loaded into 360. If one is interested
                        in knowing the exact size of the load image, use down
                        command to create refimp.dwn. Alternatively, notice the
                        size when loading the coding using onchip debugger.

libc.a libf.a           Precompiled library files for 68360.

68360.wsp               Work Space file for OnChip debugger. Edit this file
                        to make sure that the .cfg file it has points to the
                        correct one.
68360.cfg               Config File for Onchip debugger. Has all register values
                        entered properly. This file path is mentioned in .wsp file.
                    
make.exe                Precompiled make utility. Put it in your path.
                               
Usage
-----
Compiling to create loadable image:

Main Items involved in changing:
        Makefile
        apppgm.c
        custom.[hc]
Normally, there should be no need to edit any other files.

1. First make sure that the standard library is recompiled
   properly. ie. go to sds70\lib68000 dir. Edit optcc & optas
   files to reflect the -V 68360 option.

   Go to Dos window and type makelib to create libc.a and libf.a
   You should be in sds70\lib680000 dir before typing makelib.
   PreCompiled libraries can be found in libc.a and libf.a in
   the directory where you find ref imp code.

2. Edit the file sstep.ini in sds70\cmd dir. Locate the line
   for alias _down. Remove the option -m data,DATA, if it exists.
   Reason: Ref Imp. does not define the constant DATA.
   Use the OnChip Debugger for testing the code on 68360.
   Make sure that the registers are setup properly in the 
   OnChip Debugger as mentioned in the Board Manual 
   SBC360/EC Users Manual Page 5-9. See Table 5.2.
   This can be done by selecting the Target Configuration tab in
   the initial pop up window. You may be able to copy some .cfg
   file that has the necessary setup values and avoid having
   to type in all these values one by one. Look for such files,
   if it exists, in this dir.

3. Create a subdir anywhere for refimp somewhere in your harddisk
   and place all files for refimpl. Edit the makefile to reflect 
   the root dir and SDS directory.
   Browse the makefile to understand what is going on.
   Multiple stacks are supported only in simulation mode.
   (i.e no actual network involved. Packets go to all stacks 
    running on 68360).
   If you want to run more than one stack on a single chip,
   edit the line that has -DNUM_STACKS=1 to change 1 to whatever
   you want. If you change the number of stacks, make sure that
   custom.c is also edited to define parameters for each stack.
   If you are using simulation, then the line in makefile
   that defines this constant should be uncommented. If you
   are not using simulation, then the line in makefile that
   contains the line -DSIMULATION should be commented. 
   Multiple stacks are allowed only in the simulation mode.
   In simulation mode, the ISR does not run and hence there
   is no commuication with the transceiver. All the stacks
   run on 360 and a stub transfers data between the stacks to
   simulate the physical channel.
   In simulation mode, there is only one application program
   that runs in all the stacks. Make sure if it makes sense
   to run the same code in all stacks. If you use globals 
   in apppgm.c, make sure each stack's apppgm uses a different
   value. An array might be appropriate.

4. make clean 
        To remove error file and all obj files. 
        You may want to use this if you changed NUM_STACKS in 
        Makefile so that all files are compiled with this new value.

   make 
        To build refimp.out

   make newapp
        To rebuild refimp.out after changing apppgm.c (either
        by editing it or by copying another file). make should
        work, but this is sure method as it deletes app.o.
        

   make file.o 
        To make the object file for a specific file. eg. make queue.o

   After a make, always do "more errors" to make sure that there are
   no errors reported.
   
5. Understand the application program and then try running the code
   as described below.
   If everything went well, the code will work.
   
6. Alternative way to download the code to 360.
   Use "down refimp.out -d mot" to create refimp.dwn file.
   Use a communication program that can use a serial line.
   Connect 360 to a serial line. Establish connection.
   Transfer refimp.dwn by first given the command "load"
   in monitor and then giving the command to transfer ascii file
   from the communication pgm. 
   Use "symbol refimp.out > symtbl" in a dos window and grep
   the file symtbl for the constant START. This should give
   you the starting address for the code. Then type "go <startaddr>".
   Serial line will probably support up to 19000 bps. It may
   take a few minutes to download the code.

Loading
=======
When you load the code, single step will automatically run the code
until main. 
Open up the Command Window and make it visible (if needed).
You can type clear to clear the window before starting.

Type cd <refimpcodedir> (only in simulation mode)
source break (Only in simulation mode)
(The file break can be used to setup break points with continue
 option so that you can print values at appropriate places and
 continue automatically)

Now select Run (Signal light Icon with Green light).

To stop the run, click on the icon with red light.
You can reset to start from beginning again.

If you reset, do not say source break as it will create multiple
breakpoints for the same lines.

For actual run with ISR, break points are not recommened as they
might interfere with the CPU usage to make the ISR not function
properly. It does work sometimes. You can stop to check variables
and then run again. Everything should be fine.

The code has been tested well and there are no known crashes or bugs.
Please report any bugs you find to Adept Systems.

CheckList
=========
Simulation:
===========
	Make sure the line
	DEFS	   = -D NUM_STACKS=2 -D SIMULATION
	is uncommented. Change NUM_STACKS to apprpriate value.
	Comment the line
	DEFS     = -D NUM_STACKS=1 
        Copy the needed application program to apppgm.c
        Edit the custom.c file to make sure you entered the
           data for all the stacks. 
        Type make newapp.
        Load refimp.out and follow the steps in running.

Actual Testing with Physical Layer:
==================================
	Make sure the line
	DEFS     = -D NUM_STACKS=1 
	is uncommented.
	Comment the line
	DEFS	   = -D NUM_STACKS=2 -D SIMULATION

        (more than 1 stack is not supported and hence not tested
         when SIMULATION mode is not used.)
        Copy the needed application program to apppgm.c
        Edit the custom.c file to make sure you entered the
           data for all the stacks. 
        Type make newapp.
        Load refimp.out and follow the steps in running.

Using LonBuilder
----------------
To build the 360 for use with LonBuilder tool, it is necessary to
create .xif file that can be loaded into the LonBuilder. Use
a neuron C program similar to the one in 360 and use Export
command under Node Specs. Alternatively, you can query the 68360
node and use import which is probably much easier than creating
a Neuron C program.

You cannot load the application program using LonBuilder into
68360. All other commands should work, including connections etc.

Application Program
-------------------
The Refimp-final_1.7.pdf explains in detail everything you want to know
about how to write application program for reference implementation.

/***********************End of README*******************************/




