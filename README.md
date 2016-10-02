# GemV-2.0
Updated version with dyn_inst vulnerability modelling.

About
-----
gemV is an extension to the popular gem5 multicore simulation framework. 
gemV includes support for measuring the vulnerability against soft errors 
of the execution of a program on a processor architecture. Vulnerability is 
a quantitative metric to estimate the susceptibility of the execution to 
soft errors — or a measure of the probability that if a soft error strikes 
during the execution of the program, it will cause the execution to fail. 
Being a quantitative metric vulnerability allows the comparison of two 
executions, architectures, programs, protection schemes.

Currently, GemV is modeled around the ARM ISA implementation of gem5. 
It should also work for other ISAs, however vulnerability numbers will 
be incorrect for TLBs and pipeline registers.

Pre-requisites
---------------

There are several pre-requisite software packages required to build and run gem5. 
Please visit http://www.m5sim.org/Dependencies to obtain the list of dependencies. 
Install all dependencies before proceeding with the build.


Building the Simulator:
-----------------------
scons build/ARM/gem5.opt  

or 

scons build/ARM/gem5.debug 	(for running with debug information.)


Compiling benchmarks for simulation with the gemV simulator:
-----------------------------------------------------------

Compiler Sources:
-  Ubuntu users can simply install the gcc-arm-linux-gnueabi and libc6-dev-armel-cross packages
-  High quality compiler - [http://www.codesourcery.com/sgpp/lite/arm/portal/subscription3057]

arm-linux-gnueabi-gcc -static <file name>.c -o <binary>


Running the gemV Simulator:
---------------------------

Example of a command line to run gemV with vulnerability analysis enabled and Parity Word protection on the cache.

build/ARM/gem5.opt -re configs/example/se.py --cpu-type=arm_detailed --caches --vul_analysis=yes --vul_params=<path-to-params.in>
--cache_prot=parity_word -c <Full path to binary> <benchmark command-line inputs>


Parameters:
-----------
vul_analysis=[yes/no] 
        To enable or disable vulnerability analysis and output in the simulator. Also need to make ‘params.in’ text file to analyze vulnerability of each component.

	    Options (in 'params.in'):
	    
		       rob=[true/false] – Analyze vulnerability of reorder buffer
		       registerfile=[true/false] - Analyze vulnerability of register file
		       cache=[true/false] - Analyze vulnerability of cache
		       iq=[true/false] - Analyze vulnerability of instruction queue
		       lsq=[true/false] - Analyze vulnerability of load/store queue
		       pipeline=[true/false] - Analyze vulnerability of pipeline registers
		       rename=[true/false] - Analyze vulnerability of renaming unit such as history buffer and rename map


cache_prot=[no_protection/parity_word/parity_block]	:   
        Input that specifies the protection policy applied on the cache blocks.
	
	    Options:
	    
		       parity_block 	- With 'one parity bit' for the entire cache-line (block).
		       parity_word  	- With 'one parity bit' for each cache word. (Number of parity 
                                  bits in a cache-line is equal to the number of words in the cache-line.)
		       no_protection	- No protection policy applied on the cache blocks.

Output:
-------
m5out/simout 	-	gem5 Simulator output information (no gemV specific information output here)

m5out/simerr	- 	gem5 Simulator error output (no gemV specific information output here)

m5out/stats.txt	-	Simulator output stats file. 
			The vulnerability statistics of the processor components are output here, in the same format as that of gem5.


Output Information in "stats.txt"
---------------------------------
system.cpu.[icache|cache].tagArrays.vulnerability :	Vulnerability of the tag arrays in Instruction Cache

system.cpu.[icache|dcache].Vulnerability_[cache_protection] : Total vulnerability of the cache with cache protction = [cache_protection]

system.switch_cpus.dtb.vulnerability : Total vulnerability of the data TLB

system.switch_cpus.itb.vulnerability : Total vulnerability of instructions TLB

system.switch_cpus.rename.map.vulnerability : Total vulnerability of the rename map

system.switch_cpus.rename.histbuf.vulnerability : Total vulnerability of the history buffer

system.switch_cpus.iq.vulnerability : Total vulnerability of the issue queue

system.switch_cpus.iew.lsq.thread0.vulnerability : Total vulnerability of the load/store queue

system.switch_cpus.rob.vulnerability : Total vulnerability of the ROB

system.switch_cpus.regfile_vulnerability : Total vulnerability of the Register file

system.switch_cpus.TotalPRVulnerability : Total vulnerability of the Pipeline registers

All vulnerability values are calculated in bit-cycles.

Running Full system mode
------------------------
Use fullsys.sh to start the the gemV simulator in AtomicCPU mode.
Configure options and command paths in fullsys.sh before running.

After the OS boots up, use the 'm5 checkpoint' command at the prompt (connect using m5term).

Stop the simulator.

Restore gemV in DetailedCPU mode with caches enabled using restore.sh.
Configure options and command paths in restore.sh before running.


Loading benchmarks to image file
--------------------------------
Locate your image file (.img)
Mount the image file into a temporary directory using (need sudo priveleges)
	sudo mount -o loop,offset=32256 ./disks/linux-arm-ael.img ./tempdir

Disk image should now be mounted on to tempdir.
Copy compiled binaries into a folder on the disk image.
Unmount disk image using
	sudo umount ./tempdir


Useful m5 commands
------------------
Following commands can be used within the simulator (in full system mode)

1. m5 checkpoint - Creates a checkpoint
2. m5 resetstats - Resets the stat file
3. m5 dumpresetstats - Dumps the stats and resets
4. m5 dumpstats - Dumps the stats
5. m5 exit - Exits the simulator

To see more, type 'm5' at the simulator command prompt.

Limitations and assumptions
---------------------------
1. The vulnerability values computed are not exact. The bit sizes of the processor components are
   estimated based on a reasonable assumption of the microarchitecture. These sizes are parameterizable 
   under /base/vulnerability/vul_main.h
2. Branch Predictor vulnerability is assumed to be zero.
3. Vulnerability due to cache coherence is not computed. 
