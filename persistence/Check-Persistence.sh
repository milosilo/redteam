
#!/bin/bash
# Check-Persistence.sh
# This script checks for persistence vulnerabilities on a Linux host.
# The script includes basic, advanced, and very advanced checks.
# Only run this script on systems you're authorized to access.

echo -e "\n=== Checking for Cron Jobs ==="
echo "Vulnerability Explanation: Cron jobs can be used for persistence."
crontab -l

echo -e "\n=== Checking for Systemd Timers ==="
echo "Vulnerability Explanation: Systemd timers can replace cron jobs for persistence."
systemctl list-timers

echo -e "\n=== Checking for Startup Scripts ==="
echo "Vulnerability Explanation: Scripts in startup directories can achieve persistence."
ls /etc/init.d/

echo -e "\n=== Checking for SUID Binaries ==="
echo "Vulnerability Explanation: SUID binaries can be exploited for privilege escalation and persistence."
find / -perm -4000 2>/dev/null

echo -e "\n=== Checking for GUID Binaries ==="
echo "Vulnerability Explanation: GUID binaries can also be exploited."
find / -perm -2000 2>/dev/null

echo -e "\n=== Checking for Authorized Keys ==="
echo "Vulnerability Explanation: Unauthorized SSH keys can provide persistent access."
cat ~/.ssh/authorized_keys

echo -e "\n=== Script Completed with Multiple Checks. Review the results very carefully. ==="

# Enhanced Checks for Persistence

echo -e "\n=== Checking for User Crontabs ==="
echo "Vulnerability Explanation: User-specific cron jobs can be used for persistence."
for user in $(getent passwd | cut -f1 -d:); do crontab -u $user -l; done

echo -e "\n=== Checking for At Jobs ==="
echo "Vulnerability Explanation: At jobs can be used for time-based execution of tasks."
atq

echo -e "\n=== Checking for rc.local ==="
echo "Vulnerability Explanation: rc.local is executed at the end of each multiuser runlevel."
cat /etc/rc.local

echo -e "\n=== Checking for Bash Profile ==="
echo "Vulnerability Explanation: Commands in bash profile are executed on login."
cat ~/.bash_profile

echo -e "\n=== Checking for .bashrc ==="
echo "Vulnerability Explanation: Commands in .bashrc are executed for interactive shells."
cat ~/.bashrc

echo -e "\n=== Checking for SSH Config ==="
echo "Vulnerability Explanation: SSH config settings can be manipulated for persistence."
cat /etc/ssh/sshd_config

echo -e "\n=== Checking for Network Interfaces ==="
echo "Vulnerability Explanation: Network configurations can be manipulated."
ifconfig

echo -e "\n=== Checking for IPTables Rules ==="
echo "Vulnerability Explanation: IPTables rules can redirect or block network traffic."
iptables -L

echo -e "\n=== Checking for Running Services ==="
echo "Vulnerability Explanation: Running services can be exploited."
systemctl list-units --type=service

echo -e "\n=== Checking for Loaded Kernel Modules ==="
echo "Vulnerability Explanation: Kernel modules can add functionalities that might be exploited."
lsmod

echo -e "\n=== Enhanced Checks Completed. Review the results very carefully. ==="
