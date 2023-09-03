
#!/bin/bash
# Check-LateralMovement.sh
# This script checks for lateral movement vulnerabilities on a Linux host.
# The script includes basic, advanced, and very advanced checks.
# Only run this script on systems you're authorized to access.

echo -e "\n=== Checking for SSH Configurations ==="
echo "Vulnerability Explanation: SSH configurations can be exploited for lateral movement."
cat /etc/ssh/sshd_config

echo -e "\n=== Checking for Open Ports ==="
echo "Vulnerability Explanation: Open ports can be exploited for lateral movement."
netstat -tuln

echo -e "\n=== Checking for Active Connections ==="
echo "Vulnerability Explanation: Active connections can be exploited."
ss -tuln

echo -e "\n=== Checking for IPTables Rules ==="
echo "Vulnerability Explanation: IPTables rules can be manipulated."
iptables -L

echo -e "\n=== Checking for Running Services ==="
echo "Vulnerability Explanation: Running services can be exploited."
systemctl list-units --type=service

# Enhanced Checks for Lateral Movement

echo -e "\n=== Checking for NFS Shares ==="
echo "Vulnerability Explanation: NFS shares can be exploited for lateral movement."
showmount -e

echo -e "\n=== Checking for Samba Shares ==="
echo "Vulnerability Explanation: Samba shares can be exploited."
smbclient -L localhost

echo -e "\n=== Checking for ARP Cache ==="
echo "Vulnerability Explanation: ARP cache can reveal network structure."
arp -a

echo -e "\n=== Checking for SNMP Configurations ==="
echo "Vulnerability Explanation: SNMP can be exploited for information gathering."
cat /etc/snmp/snmpd.conf

echo -e "\n=== Checking for Kerberos Tickets ==="
echo "Vulnerability Explanation: Kerberos tickets can be exploited."
klist

echo -e "\n=== Enhanced Checks Completed. Review the results very carefully. ==="
