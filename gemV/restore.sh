# Script to run GemV in full system mode with vulnerability analysis enabled

protection=parity_word								# Protection scheme to be used
vul_analysis=yes								# Enable/disable vulnerability analsys
cpu_type=arm_detailed								# Should be arm_detailed
num_procs=1									# Number of processors. Should be the same as fullsys.sh
num_l2=1									# Number of L2 caches
l1d_size=8kB									# Size of L1 Data cache
l1i_size=4kB									# Size of L1 Instruction cache
l2_size=32kB									# Size of L2 cache
l1d_assoc=2									# L1 Data cache associativity
l1i_assoc=2									# L1 Instuction cache associativity
l2_assoc=4									# L2 associativity
cacheline_size=64								# Size of cache line
restore_num=1									# Checkpoint restore number
outdir=../out/fs/mibench/o1/					# Output directory path
checkpointdir=../checkpoints/mibench/c1/			# Checkpoint directory path
gemv_exec_path=./build/ARM/gem5.opt		# Path to gemV executable
disk_path=~/dist/disks/linux-arm-ael.img		# Path to disk image
kernel_path=~/dist/binaries/vmlinux.arm.smp.fb.2.6.38.8
config_path=./configs/example/fs.py		# Path to config file
mem=256MB


$gemv_exec_path -d $outdir  $config_path --checkpoint-dir=$checkpointdir --disk-image=$disk_path --kernel=$kernel_path --cpu-type=$cpu_type --caches --l2cache -n $num_procs --num-l2caches=$num_l2 --l1d_size=$l1d_size --l1i_size=$l1i_size --l2_size=$l2_size --l1d_assoc=$l1d_assoc --l1i_assoc=$l1i_assoc --l2_assoc=$l2_assoc --cacheline_size=$cacheline_size --vul_analysis=$vul_analysis --cache_prot=$protection --mem-size=$mem -r $restore_num --restore-with-cpu detailed
