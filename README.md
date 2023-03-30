# PowerDesigner-MDDE-Extension
A PowerDesigner LDM extension to support Model Driven Data Engineering using PowerDesigner LDM models.

This extensions is to add extra modeling possibilities to LDM models, where standard PowerDesigner functionalities are missing options to add metadata.

## Prerequisites

> Prerequisites on your machine:
> - PowerShell 7 or higher installed. Download it [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows#msi)
> - Java JRE/JDK >= 11.

### PowerShell settings

In order to exucute the PowerShell scripts, make sure you run the following command once in PowerShell:

``` powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### Git settings

To be able to version PowerDesigner files in Git we use PowerDeComposer. In order for PowerDeComposer to work correctly with git, some settings have to be done on the local git repository (after cloning this repository for the first time).

> When you remove the whole git folder and get a fresh clone you have to re-do these steps!

In VS Code right-click on the 'models' folder and click 'Open In Integrated Terminal'. On the terminal execute the following commands:

``` powershell
git config --local core.ignorecase true
git config --local core.autocrlf input
git config --local core.fileMode false
git config --local core.longpaths true
```

## PowerDesigner named paths

Create the following named paths in PowerDesigner (via Tools -> General Options... -> Named Paths). In the Path the {Git-Folder} part should be replaced with the folder reference relative to the root of this repository on your machine. For the [XEM] config, only add the path, don't remove existing entries.

| Name             | Path                                |
|----------------------|---------------------------------|
| PDC_SCRIPT_PATH    | {Git-Folder}\pdc\                 |
| [XEM]              | {Git-Folder}\composed\extensions\ |

## Manual
There is a manual available [here](./manual/) on how to use the PowerDesigner extension.

## On branch clone/switch

> Before switching branch, make sure all your changes in PowerDesigner models are decomposed and commited into Git.

After every branch update, clone or switch, make sure the close PowerDesigner and run:

``` powershell
./compose.ps1
```

This will compose all models based on the decomposed folder contents. The composed models are not automatically updated on a branch change.

> If a merge conflict accured during the branch change in de decomposed models somewhere, merge it manually carefully. If you're done you can run compose.ps1 and open the models in PowerDesigner to check whether everything is merged correctly.
