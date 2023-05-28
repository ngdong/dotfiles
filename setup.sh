#!/bin/bash

# Checking system infomation...
cpu_name=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cpu_cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
cpu_freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
cpu_freq_gb=$(echo "scale=0;$cpu_freq/1000" | bc)
ram_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
ram_mb=$(echo "scale=0;$ram_total/1024" | bc)
swap_total=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
swap_mb=$(echo "scale=0;$swap_total/1024" | bc)
hdd=$(df -h | awk 'NR==2 {print $2}')

printf "System Infomation\n"
printf "=========================================================================\n"
echo "Processor Name : -------------$cpu_name"
echo "# of Cores : -----------------$cpu_cores"
echo "Processor Base Frequency : ---$cpu_freq_gb GHz"
echo "Memory : ---------------------$ram_mb MB"
echo "Swap memory : ----------------$swap_mb MB"
echo "Hard disk space : ------------$hdd GB"
printf "=========================================================================\n"

echo "---------------------------------------------------------"
echo "$(tput setaf 2)------------------------START----------------------------$(tput sgr 0)"
index=0
packages=(
	"update"
	"git"
	"vscode"
	"terminal"
	"tmux"
	"zsh"
	"node"
	"neovim"
	"dotnet"
	"docker"
)
for i in "${packages[@]}"; do
	target="$PWD/tools/$i.sh"
	if [ -f "$target" ]; then
		index=$((index + 1))
		echo "---------------------------------------------------------"
		echo "$(tput setaf 2)$index: Installing ${i^}.$(tput sgr 0)"
		source $target
	fi
done
echo "---------------------------------------------------------"
echo "$(tput setaf 2)-------------------------END-------------------------------$(tput sgr 0)"
echo "---------------------------------------------------------"
# Set default bash shell
chsh -s $(which zsh)
sudo reboot
