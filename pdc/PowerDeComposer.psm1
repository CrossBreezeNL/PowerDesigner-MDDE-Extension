###
# PowerDeComposer PowerShell module
###

# The location of the PowerDeComposer jar file.
$PDCJarLocation = Join-Path -Path $PSScriptRoot -ChildPath "PowerDeComposer.jar"
# Set minimum memory to 64MB and maximum to 2GB.
$JavaArguments = @("-Xms128M", "-Xmx2G", "-jar", "-Dfile.encoding=UTF-8", "`"$PDCJarLocation`"")
# The location of the PowerDeComposer LDM config file.
$LdmConfigFileLocation = Join-Path -Path $PSScriptRoot -ChildPath "pdc_config_ldm.xml"
# The location of the PowerDeComposer XEM config file.
$XemConfigFileLocation = Join-Path -Path $PSScriptRoot -ChildPath "pdc_config_xem.xml"
# The location of the PowerDeComposer SWS config file.
$SwsConfigFileLocation = Join-Path -Path $PSScriptRoot -ChildPath "pdc_config_sws.xml"

# Function to invoke PowerDeComposer as a java call.
Function Invoke-PowerDeComposer {
    param (
        $Mode,
        $InputLocation,
        $OutputLocation,
        $ConfigFileLocation,
        $LogFileLocation
    )

    # Create the Java call arguments list.
    $JavaCall = $JavaArguments + @($Mode, "`"$InputLocation`"", "`"$OutputLocation`"")
    # If the config file locatin is set, add it to the java call.
    if ($ConfigFileLocation.Length -gt 0) {
        $JavaCall = $JavaCall + @("`"$ConfigFileLocation`"")
    }

    # Start the java process for PowerDeComposer and wait for it to finish.
    if ($LogFileLocation.Length -gt 0) {
        $pdcProcess = Start-Process -FilePath "java" -ArgumentList $JavaCall -PassThru -Wait -NoNewWindow -RedirectStandardOutput $LogFileLocation
    } else {
        $pdcProcess = Start-Process -FilePath "java" -ArgumentList $JavaCall -PassThru -Wait -NoNewWindow
    }
    # If the PowerDeComposer process hasn't excited yet at this point, close it.
    if (!$pdcProcess.HasExited) {
        $pdcProcess.Close()
        # If the ExitCode is 0, return 1, because we had to stop the process ourselves.
        if ($pdcProcess.ExitCode.Equals(0)) {
            return 1
        }
    }
    # Return the exit code of the java process.
    return $pdcProcess.ExitCode
}

# Function to invoke a decompose.
function Invoke-DecomposeModel {
    param (
        $ModelFileLocation,
        $TargetFolderLocation,
        $ConfigFileLocation
    )

    $TargetFolderLocation_Exists = Test-Path $TargetFolderLocation
    # If the target folder doesn't exist, create it.
    If (!$TargetFolderLocation_Exists) {
        Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm:ss.f') ## The target folder location ($TargetFolderLocation) doesn't exist, so creating it."
        New-Item -ItemType "Directory" -Path $TargetFolderLocation | Out-Null # Ignore the output.
    }

    # Store a decompose.log in the target folder.
    $LogFileName = (Split-Path -Path $ModelFileLocation -LeafBase) + ".decompose.log"
    $LogFileLocation = Join-Path -Path $TargetFolderLocation -ChildPath $LogFileName
    # Use the Invoke-PowerDeComposer function to perform the decompose.
    $ProcessResults = Invoke-PowerDeComposer -Mode "decompose" -InputLocation $ModelFileLocation -OutputLocation $TargetFolderLocation -ConfigFileLocation $ConfigFileLocation -LogFileLocation $LogFileLocation
    # If the process failed, throw the error.
    if (!$ProcessResults.Equals(0)) {
        throw "Decomposing '$ModelFileLocation' failed. Check the log file for errors."
    }
}

# Function to invoke a model compose.
function Invoke-ComposeModel {
    param (
        $ModelFileLocation,
        $TargetFileLocation
    )

    $TargetFolderLocation = Split-Path -Path $TargetFileLocation -Parent
    $TargetFolderLocation_Exists = Test-Path $TargetFolderLocation
    # If the target folder doesn't exist, create it.
    If (!$TargetFolderLocation_Exists) {
        Write-Host "$(Get-Date -format 'dd-MM-yyyy HH:mm:ss.f') ## The target folder location ($TargetFolderLocation) doesn't exist, so creating it."
        New-Item -ItemType "Directory" -Path $TargetFolderLocation | Out-Null # Ignore the output.
    }

    # Store a decompose.log in the target folder.
    $LogFileName = (Split-Path -Path $TargetFileLocation -LeafBase) + ".compose.log"
    $LogFileLocation = Join-Path -Path $TargetFolderLocation -ChildPath $LogFileName
    # Use the Invoke-PowerDeComposer function to perform the decompose.
    $ProcessResults = Invoke-PowerDeComposer -Mode "compose" -InputLocation $ModelFileLocation -OutputLocation $TargetFileLocation -LogFileLocation $LogFileLocation
    # If the process failed, throw the error.
    if (!$ProcessResults.Equals(0)) {
        throw "Composing '$ModelFileLocation' failed"
    }
}
Export-ModuleMember -Function Invoke-ComposeModel

# Function to invoke a LDM model decompose.
function Invoke-DecomposeLDM {
    param (
        $ModelFileLocation,
        $TargetFolderLocation
    )

    #Write-Host "[Invoke-DecomposeLDM] ModelFileLocation='$ModelFileLocation'; TargetFolderLocation='$TargetFolderLocation'"
    Invoke-DecomposeModel -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation -ConfigFileLocation $LdmConfigFileLocation
}
Export-ModuleMember -Function Invoke-DecomposeLDM

# Function to invoke a XEM decompose.
function Invoke-DecomposeXEM {
    param (
        $ModelFileLocation,
        $TargetFolderLocation
    )

    Invoke-DecomposeModel -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation -ConfigFileLocation $XemConfigFileLocation
}
Export-ModuleMember -Function Invoke-DecomposeXEM

# Function to invoke a XEM decompose.
function Invoke-DecomposeSWS {
    param (
        $ModelFileLocation,
        $TargetFolderLocation
    )

    Invoke-DecomposeModel -ModelFileLocation $ModelFileLocation -TargetFolderLocation $TargetFolderLocation -ConfigFileLocation $SwsConfigFileLocation
}
Export-ModuleMember -Function Invoke-DecomposeSWS