
# Check-Persistence-Enhanced.sh

## Overview
This Bash script is designed to check for persistence vulnerabilities on a Linux host. The script includes basic, advanced, and very advanced checks and is intended for use by security professionals. Only run this script on systems where you have authorized access.

## Features
The script performs a wide range of checks, each designed to identify potential persistence vulnerabilities.

### Basic Checks

#### Cron Jobs
- Checks for system-wide cron jobs.
- Vulnerability Explanation: Cron jobs can be used for persistence.

#### Systemd Timers
- Checks for Systemd timers.
- Vulnerability Explanation: Systemd timers can replace cron jobs for persistence.

#### Startup Scripts
- Checks for startup scripts in /etc/init.d/.
- Vulnerability Explanation: Scripts in startup directories can achieve persistence.

#### SUID Binaries
- Checks for SUID binaries.
- Vulnerability Explanation: SUID binaries can be exploited for privilege escalation and persistence.

#### GUID Binaries
- Checks for GUID binaries.
- Vulnerability Explanation: GUID binaries can also be exploited.

#### Authorized Keys
- Checks for authorized SSH keys.
- Vulnerability Explanation: Unauthorized SSH keys can provide persistent access.

### Enhanced Checks

#### User Crontabs
- Checks for user-specific cron jobs.
- Vulnerability Explanation: User-specific cron jobs can be used for persistence.

#### At Jobs
- Checks for At jobs.
- Vulnerability Explanation: At jobs can be used for time-based execution of tasks.

#### rc.local
- Checks the content of /etc/rc.local.
- Vulnerability Explanation: rc.local is executed at the end of each multiuser runlevel.

#### Bash Profile
- Checks the content of the user's bash profile.
- Vulnerability Explanation: Commands in bash profile are executed on login.

#### .bashrc
- Checks the content of the user's .bashrc file.
- Vulnerability Explanation: Commands in .bashrc are executed for interactive shells.

#### SSH Config
- Checks the SSH server configuration.
- Vulnerability Explanation: SSH config settings can be manipulated for persistence.

#### Network Interfaces
- Checks the active network interfaces.
- Vulnerability Explanation: Network configurations can be manipulated.

#### IPTables Rules
- Checks the IPTables rules.
- Vulnerability Explanation: IPTables rules can redirect or block network traffic.

#### Running Services
- Checks the running services.
- Vulnerability Explanation: Running services can be exploited.

#### Loaded Kernel Modules
- Checks the loaded kernel modules.
- Vulnerability Explanation: Kernel modules can add functionalities that might be exploited.

## Usage
Run this script with administrative privileges:

```
sudo ./Check-Persistence-Enhanced.sh
```

## Disclaimer
This script is intended for educational and professional use only. Always consult with your organization's legal and compliance teams before running any security assessments.
