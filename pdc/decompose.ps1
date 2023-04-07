# Define arguments to be populated by the method in PowerDesigner
$ComposedFileLocation=$args[0] # For Example "LDM"

# Set the debug preference to Continue so the debug output is printed. Default is SilentlyContinue.
$DebugPreference = "SilentlyContinue"
#$DebugPreference = "Continue"

# Include PowerDeComposer PowerShell Functions.
$ImportModulePath = Join-Path -Path $PSScriptRoot -ChildPath "PowerDeComposer.psm1"
Import-Module -Name $ImportModulePath -Force

# Variables used for PowerDeComposer.
$PDCBasePath = Split-Path -Path $PSScriptRoot -Parent
$ComposedFolder = Join-Path -Path $PDCBasePath -ChildPath "composed"
$DecomposedFolder = Join-Path -Path $PDCBasePath -ChildPath "decomposed"

# Construct the TargetFolderLocation using the parent folder of the composed file and replacing the ComposedFolder with the decomposed folder.
$TargetFolderLocation = Join-Path -Path (Split-Path -Path $ComposedFileLocation -Parent).Replace($ComposedFolder, $DecomposedFolder) -ChildPath (Split-Path -Path $ComposedFileLocation -LeafBase)

# Extension argument will be used as the actual extension of the file, so make it lowercase.
$FileExtension = (Split-Path -Path $ComposedFileLocation -Extension).ToLower()

Write-Host "Decomposing $ComposedFileLocation to $TargetFolderLocation..."

switch ($FileExtension) {
    ".xem" {  
        # Invoke the Decompose on the XEM.
        Invoke-DecomposeXEM -ModelFileLocation $ComposedFileLocation -TargetFolderLocation $TargetFolderLocation
    }
    ".ldm" { 
        # Invoke the Decompose on the LDM.
        Invoke-DecomposeLDM -ModelFileLocation $ComposedFileLocation -TargetFolderLocation $TargetFolderLocation
     }
    ".pdm" {
        # Invoke the Decompose on the PDM using the LDM config.
        # TODO: Change this to call a DecomposePDM function and have a specific configuration for this.
        Invoke-DecomposeLDM -ModelFileLocation $ComposedFileLocation -TargetFolderLocation $TargetFolderLocation
    }
    ".sws" {  
        # Invoke the Decompose on the SWS.
        Invoke-DecomposeSWS -ModelFileLocation $ComposedFileLocation -TargetFolderLocation $TargetFolderLocation
    }    
    Default {}
}

Write-Host "Done"