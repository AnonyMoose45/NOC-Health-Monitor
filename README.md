# NOC Automated Health Monitor

## Project Overview

The NOC Automated Health Monitor is a Bash script designed
to automate routine Linux system health checks.

The script collects live system telemetry, evaluates disk
usage against a predetermined threshold, and appends the
results to a persistent log file.

This allows Network Operations Center (NOC) personnel to
monitor system resources, identify potential storage issues,
and maintain historical records for troubleshooting.

## Features

- Automated timestamp generation
- One-minute CPU load monitoring
- Available RAM monitoring
- Available disk space monitoring
- Disk utilization warnings at 80% or higher
- Persistent system health logging

## Prerequisites

- Linux environment (Ubuntu, Parrot OS, or WSL)
- Bash
- Standard Linux utilities (date, df, awk, sed, free)
- Cron for automated execution

## Setup and Execution

Navigate to the project directory.

Make the script executable:

    chmod +x health_check.sh

Execute the script:

    ./health_check.sh

View the generated health report:

    cat system_health.log

Each execution appends a new report to the log file
without overwriting previous reports.

## Automation (Cron)

To automate the health check, open the user's crontab:

    crontab -e

Add the following entry:

    0 * * * * "$HOME/NOC-Health-Monitor/health_check.sh"

This executes the script at the beginning of every hour.

The $HOME variable automatically references the current
user's home directory. If the repository is installed
in a different location, adjust the path accordingly.

The Cron service must be running.

## Evaluation Logic

- Below 80% disk utilization: OK
- At or above 80% disk utilization: WARNING

## Author

AnonyMoose
