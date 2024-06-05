# Contributing

The PowerDesigner MDDE extension is an open-source project. One of the goals is to share the extensions across multiple organisations and accept contributions from any of them. This repository contains all MDDE extensions for PowerDesigner which are generic enough to be shared across organizations.

Please follow the instructions below on how to setup your local environment and how to compose and decompose the extensions/models.

## Prerequisites
These prerequisites are only needed when you want to compose or decompose the extensions and/or example models. This is not necessary if you only want to use the extension as is, which can be downloaded from any [release](https://github.com/CrossBreezeNL/PowerDesigner-MDDE-Extension/releases/).

- PowerShell 7 or higher. Download it [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows#msi)
- Java JRE/JDK >= 11.

## PowerShell settings

In order to execute the PowerShell scripts, make sure you run the following command once in PowerShell:

``` powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

## Git settings

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

Create the following named paths in PowerDesigner (via Tools -> General Options... -> Named Paths). In the Path the {Git-Folder} part should be replaced with the folder reference relative to the root of this repository on your machine. For the [XEM] config, only add the path, don't remove existing entries. The MDDE_EXT_MODELS entry is only for the example models in this repository, it's not needed for using the extension in your own models.

| Name                 | Path                              |
|----------------------|-----------------------------------|
| PDC_SCRIPT_PATH      | {Git-Folder}\pdc\                 |
| [XEM]                | {Git-Folder}\composed\extensions\ |
| MDDE_EXT_MODELS      | {Git-Folder}\composed\            |

## On branch clone/switch

> Before switching branch, make sure all your changes in PowerDesigner models are decomposed and committed into Git.

Model changes can be decomposed using the context menu of the model (see [PowerDeComposer manual](./manual/PowerDeComposer.md)).

Changes in the Workspace or Extensions can be decomposed using the following command:
``` powershell
decompose_sws_xem.ps1
```

After every branch update, clone or switch, make sure to close PowerDesigner and run:

``` powershell
compose.ps1
```

This will compose all models based on the decomposed folder contents. The composed models are not automatically updated on a branch change.

> If a merge conflict occurs during the branch change in de decomposed models somewhere, merge it manually carefully. If you're done you can run compose.ps1 and open the models in PowerDesigner to check whether everything is merged correctly.
