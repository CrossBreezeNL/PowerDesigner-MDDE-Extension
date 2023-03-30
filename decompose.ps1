# Set the debug preference to Continue so the debug output is printed. Default is SilentlyContinue.
$DebugPreference = "SilentlyContinue"
#$DebugPreference = "Continue"

# Include PowerDeComposer PowerShell Functions.
$PDCModuleLocation = "$PSScriptRoot\pdc\PowerDeComposer.psm1"

# Variables used for PowerDeComposer.
$ComposedFolder = "$PSScriptRoot\composed"
$DecomposedFolder = "$PSScriptRoot\decomposed"

# Decompose all ldm, pdm, xem and sws files.
# Enable the Measure-Command to measure the run times (uncomment line 14 and 45).
#Measure-Command -Expression {
    Get-ChildItem -Path $ComposedFolder -Include "*.xem","*.sws","*.ldm" -Recurse -Depth 2 |
    ForEach-Object -Parallel {
        # Include PowerDeComposer PowerShell Functions.
        Import-Module -Name $using:PDCModuleLocation -Force
        # The model file location is the full name of the found file.
        $ModelFileLocation = $_.FullName
        # Construct the Decomposed folder for the model based on the location of the composed model.
        $TargetFolderLocation = Join-Path -Path $_.Directory.FullName.Replace($using:ComposedFolder, $using:DecomposedFolder) -ChildPath $_.BaseName
        Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm:ss.f') ## Start decomposing $ModelFileLocation to $TargetFolderLocation..."
        # Invoke the Decompose on the file based on the file extension.
        switch ($_.Extension) {
            ".xem" {
                # Invoke the Decompose on the XEM.
                Invoke-DecomposeXEM -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation
            }
            ".ldm" {
                # Invoke the Decompose on the LDM.
                Invoke-DecomposeLDM -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation
            }
            ".sws" {
                # Invoke the Decompose on the SWS.
                Invoke-DecomposeSWS -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation
            }    
            Default {}
        }
        Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm:ss.f') ## End decomposing $ModelFileLocation."
    } -ThrottleLimit 5
 #| Out-Default }

Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm:ss.f') ## Done"
