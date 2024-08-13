# Eamonn Morris
# Snippet to verify that a script is running under PS 7 vs. 5
#

function Confirm-PSVersion {
    if ($PSVersionTable.PSVersion.Major -lt 7) {
        Write-Warning "This script requires PowerShell 7 or higher. You are running version $($PSVersionTable.PSVersion)."
        $confirmation = Read-Host "Do you want to continue anyway? (y/n)"
        if ($confirmation -ne 'y') {
            Write-Output "Exiting script"
            # return 1
        }
    }
}

Confirm-PSVersion