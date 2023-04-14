# Set the debug preference to Continue so the debug output is printed. Default is SilentlyContinue.
$DebugPreference = "SilentlyContinue"
#$DebugPreference = "Continue"

# Include PowerDeComposer PowerShell Functions.
$PDCModuleLocation = Join-Path -Path $PSScriptRoot -ChildPath "pdc/PowerDeComposer.psm1"

# Variables used for PowerDeComposer.
$ComposedFolder = Join-Path -Path $PSScriptRoot -ChildPath "composed"
$DecomposedFolder = Join-Path -Path $PSScriptRoot -ChildPath "decomposed"

# Compose all decomposed model files.
# Enable the Measure-Command to measure the run times (uncomment line 14 and 27).
#Measure-Command -Expression {
    Get-ChildItem -Path "$DecomposedFolder" -Include "*.ldm", "*.sws", "*.xem" -Recurse -Depth 2 |
    ForEach-Object -Parallel {
        Import-Module -Name $using:PDCModuleLocation -Force
        # The model file location is the full name of the found file.
        $ModelFileLocation = $_.FullName
        # Construct the Decomposed folder for the model based on the location of the composed model.
        $TargetFileLocation = Join-Path -Path $_.Directory.Parent.FullName.Replace($using:DecomposedFolder, $using:ComposedFolder) -ChildPath $_.Name
        # Log the start of the compose.
        Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm') ## Composing $ModelFileLocation to $TargetFileLocation..."
        # Invoke the Decompose on the LDM.
        Invoke-ComposeModel -ModelFileLocation $ModelFileLocation -TargetFileLocation $TargetFileLocation
    } -ThrottleLimit 5
 #| Out-Default }

 Write-Host "Done."