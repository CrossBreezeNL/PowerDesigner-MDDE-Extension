> [Modeling](./README.md) > Model checks

# Model checks

One of the standard functionalities of PowerDesigner is to execute model checks on a model. By default there is a list of model checks available which can be very helpfull. Since we add functionality as part of the PowerDesigner extension we also need to validate (check) what is been modeled. For this new model checks are introduced.

## Execute model checks

To execute model checks on any model execute the following steps:

1. Open a diagram of the model to check and make sure it is the active diagram.
2. Go to 'Tools' in the main menu and select 'Check Model...' (or press F4). This will open the 'Check Model Parameters' modal box.
3. On the 'Options' tab configurate which model checks to execute (this will be stored in the model, so next time the same set of checks will be executed).
4. On the 'Selection' tab configure which objects to check. By default all objects are selected.
5. Click 'OK' to execute the model checks.

![Model check parameters](img\model_check_parameters.png)

## Model check results

Once the model checks are executed a 'Result List' tab will be opened which contains the model check results. If the list is empty, there are no failed model checks. If the list contains records one or more model checks found a possible problem with your model.

![Model check result list](img\model_check_result_list.png)

The name of the can be found in the 'Check' column. If the name of the check starts with 'mdde_' it is a custom check implementated as part of the modeling extension. Otherwise it is a standard PowerDesigner model check.

### Interpreting custom model check

When it is a custom model check (of MDDE) there will be extra information about the problem in the 'Script' output tab (usually in the bottom of your PowerDesigner screen).

![Output script tab](img\model_check_output_script_tab.png)

[Go back to main modeling page](./README.md)