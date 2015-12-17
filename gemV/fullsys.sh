# Script to run GemV in full system mode with vulnerability analysis enabled

protection=parity_word							# Protection scheme to use 
cpu_type=atomic								# Should be atomic
num_procs=1								# Set number of processors
outdir=../out/fs/mibench/o1/				# Path to output directory
checkpoint_dir=../checkpoints/mibench/c1/		# Path to checkpoint directory
gemv_exec_path=./build/ARM/gem5.opt 	# Path to gemV executable
config_path=./configs/example/fs.py	# Path to config file
disk_path=~/dist/disks/linux-arm-ael.img # Path to disk image
script_path=../scripts/mibench.rcS
kernel_path=~/dist/binaries/vmlinux.arm.smp.fb.2.6.38.8
mem=256MB

$gemv_exec_path -d $outdir $config_path --kernel=$kernel_path --disk-image=$disk_path --script=$script_path --checkpoint-dir=$checkpoint_dir --cpu-type=$cpu_type -n $num_procs --mem-size=$mem
