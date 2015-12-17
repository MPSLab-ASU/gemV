# Script to run GemV in SE mode with vulnerability analysis enabled
# ******************	       IMPORTANT	  *****************
# ** Check the paths and options below before running the script **
# *****************************************************************

protection=parity_word								# Protection scheme to be used
vul_analysis=yes								# Enable/Disable vulnerability analysis
cpu_type=arm_detailed								# CPU Type
num_procs=1									# Number of processors
num_l2=1									# Number of L2 caches
l1d_size=8kB									# Size of L1 Data cache
l1i_size=4kB									# Size of L1 Instruction cache
l2_size=32kB									# Size of L2 cacche
l1d_assoc=2									# L1 Data cache associativity
l1i_assoc=2									# L1 Instruction cache associativity
l2_assoc=4									# L2 associativity
cacheline_size=64					            			# Size of cache line
out_dir1=../out/FFT/	    						# Path to output directory
out_dir2=../out/dijkstra/							# Path to output directory
out_dir3=../out/qsort/							# Path to output directory
binary2=~/benchmarks/mibench/network/dijkstra/dijkstra_large		# Path to binary
binary3=~/benchmarks/mibench/automotive/qsort/qsort_small		# Path to binary
binary1=~/benchmarks/mibench/telecomm/FFT/fft		# Path to binary
options2=~/benchmarks/mibench/network/dijkstra/input.dat					# Options to be passed to the binary. Add "-o $options" to the end of the command if any options exist.
options3=~/benchmarks/mibench/automotive/qsort/input_small.dat					# Options to be passed to the binary. Add "-o $options" to the end of the command if any options exist.
#options=4 4096					# Options to be passed to the binary. Add "-o $options" to the end of the command if any options exist.
gemv_exec_path=./build/ARM/gem5.opt		# Path to gemv executable
config_path=./configs/example/se.py		# Path to config file


$gemv_exec_path -d $out_dir1 $config_path --cpu-type=$cpu_type --caches --l2cache -n $num_procs --num-l2caches=$num_l2 --l1d_size=$l1d_size --l1i_size=$l1i_size --l2_size=$l2_size --l1d_assoc=$l1d_assoc --l1i_assoc=$l1i_assoc --l2_assoc=$l2_assoc --cacheline_size=$cacheline_size --vul_analysis=yes -c $binary1 -o "4 4096"
$gemv_exec_path -d $out_dir2 $config_path --cpu-type=$cpu_type --caches --l2cache -n $num_procs --num-l2caches=$num_l2 --l1d_size=$l1d_size --l1i_size=$l1i_size --l2_size=$l2_size --l1d_assoc=$l1d_assoc --l1i_assoc=$l1i_assoc --l2_assoc=$l2_assoc --cacheline_size=$cacheline_size --vul_analysis=yes -c $binary2 -o $options2
$gemv_exec_path -d $out_dir3 $config_path --cpu-type=$cpu_type --caches --l2cache -n $num_procs --num-l2caches=$num_l2 --l1d_size=$l1d_size --l1i_size=$l1i_size --l2_size=$l2_size --l1d_assoc=$l1d_assoc --l1i_assoc=$l1i_assoc --l2_assoc=$l2_assoc --cacheline_size=$cacheline_size --vul_analysis=$vul_analysis --cache_prot=$protection -c $binary3 -o $options3
