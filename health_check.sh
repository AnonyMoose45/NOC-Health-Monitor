#!/bin/bash

# LCCC Cybersecurity NOC - System Health Monitor
# Author: AnonyMoose

# Define the log file location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/system_health.log"

# 1. Generate Timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# 2. Gather System Telemetry

# Get root partition disk usage percentage
DISK_USAGE=$(df -P / | awk 'NR==2 {print $5}' | sed 's/%//')

# Get available disk space
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')

# Get the 1-minute CPU load average
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)

# Get available RAM in megabytes
RAM_FREE=$(free -m | awk 'NR==2 {print $7}')

# 3. Evaluation Logic
THRESHOLD=80

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    STATUS="[WARNING] Disk usage is critically high at ${DISK_USAGE}%!"
else
    STATUS="[OK] Disk usage is stable at ${DISK_USAGE}%."
fi

# 4. Format and Write to Log
{
    echo "----------------------------------------"
    echo "NOC Health Report - $TIMESTAMP"
    echo "CPU Load (1m) : $CPU_LOAD"
    echo "Available RAM : ${RAM_FREE} MB"
    echo "Free Disk     : $DISK_FREE"
    echo "Disk Status   : $STATUS"
    echo "----------------------------------------"
} >> "$LOG_FILE"

# Notify the operator
echo "Health check executed. Results logged to $LOG_FILE"