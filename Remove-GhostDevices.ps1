# Eamonn Morris
# Script scans host for devices entries belonging to previously installed HW devices and removes them
# Ex. Devices that are 'hidden' and show error code 45
# Used primarily after performing P2V to quickly remove entries from the previous bare metal host

function Get-UnknownDevices {
    param (
        [switch]$Display = $false,
        [switch]$Delete = $false
    )
    $unknownDevices = Get-PnpDevice | Where-Object {($_.Status -eq 'Unknown')}
    # $unknownDevices | ForEach-Object {Write-Output $_.Name, $_.InstanceId, "`n"}
    if ($Display) {
        $unknownDevices | Sort-Object Class, Name | Format-Table Name, Class -auto
    }
    else {
        return $unknownDevices;
    }
    if ($Delete) {
        Start-Transcript -LiteralPath "$PSScriptRoot\ghost-device.txt" -Append
        foreach ($u in $unknownDevices) {
            <# $u is $unknownDevices current item #>
            Write-Output "Found $u.Name"
            & pnputil.exe /remove-device $u.InstanceId | Out-Default
        }
        Stop-Transcript
    }
}
