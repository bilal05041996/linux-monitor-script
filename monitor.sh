#!/bin/bash

#Description: A simple Linux system monitoring script

#Log file (you can change this path).Sets the path of your log file. All the output will be saved to /var/log/sys_monitor.log

LOG_FILE="/var/log/sys_monitor.log"

#Create log file if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
	sudo touch "$LOG_FILE"
	sudo chmod 644 "$LOG_FILE"
fi

#Prints a header line to the terminal and appends it to the log file
echo "--- System Monitor Report ---" | tee -a "$LOG_FILE"

#Adds current date and time to the report
echo "Date & Time : $(date)" | tee -a "$LOG_FILE"

#It shows how long the system has been running in human readable format
echo "Uptime : $(uptime -p)" | tee -a "$LOG_FILE"

#prints the cpu load average
echo "CPU Load : $(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')" | tee -a "$LOG_FILE"

#prints the system memory usage
echo "Memory : $(free -hg | awk '/Mem:/ {print $3 " / " $2}')" | tee -a "$LOG_FILE"

#prints the disk usage percentage of root (/) file system
echo "Disk Usage: $(df -h | awk 'END{print $5 " used on " $1}')" | tee -a "$LOG_FILE"

#prints the number of active (established) network connections on your system
echo "Network: $(ss -tunapl | grep ESTAB | wc -l) active connection"
