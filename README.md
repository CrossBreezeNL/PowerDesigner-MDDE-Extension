# PowerDesigner-MDDE-Extension
A PowerDesigner LDM extension to support Model Driven Data Engineering using PowerDesigner LDM models.

This extensions is to add extra modeling possibilities to LDM models, where standard PowerDesigner functionalities are missing options to add metadata. These extra modeling options are listed below per object type.

- Entity
  - Mapping
    - Custom source objects tab on mappings.
      - To support using the same source object twice in a mapping in a different  role.
      - To specify join type and conditions on source objects.
      - To specify period offsets on source objects (for example last month).
    - Examples tab on mappings so example input and output data can be specified in the model.
  - Business rule (stereotype)
    - Add support for modeling business rules with input/output attributes and examples.
    - Supported sub-stereotypes:
      - Scalar business rule
      - Filter business rule
- Model checks
  - Extra model checks have been implemented to verify the newly supported objects.
- PowerDeComposer integration
  - To allow version management of PowerDesigner files in Git the tool PowerDeComposer have been implemented. In this extension a menu item on models have been added to decompose a model using PowerDeComposer.

## Modeling manual
There is a modeling manual available [here](./manual/) on how to use the PowerDesigner extension.

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

## On branch clone/switch

> Before switching branch, make sure all your changes in PowerDesigner models are decomposed and commited into Git.

After every branch update, clone or switch, make sure to close PowerDesigner and run:

``` powershell
./compose.ps1
```

This will compose all models based on the decomposed folder contents. The composed models are not automatically updated on a branch change.

> If a merge conflict accured during the branch change in de decomposed models somewhere, merge it manually carefully. If you're done you can run compose.ps1 and open the models in PowerDesigner to check whether everything is merged correctly.
