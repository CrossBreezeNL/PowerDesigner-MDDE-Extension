> [Modeling](./README.md) > Frequently asked questions

# Frequently asked questions

## Why don't I see the tab mentioned in the manual?

If you don't see a certain tab on an object, click on the 'More >>' button in the bottom left of the object dialog (the button is '<< Less' if the tab is already visible).

## How can I add a certain property to a table grid?

When you are in a screen where you can edit a list of data (in a table grid) you can add properties using the 'Customize Columns and Filter' toolbar button.

![Customize Columns and Filters](img\faq_table_grid_add_columns.png)

## I get a confirmation dialog to commit changes, what to do?

Sometimes a dialog screen pops up with the question whether you want to commit, like in the image below:

![PowerDesigner commit object creation](img\powerdesigner_commit_message.png)

When this is asked, choose 'Yes'.

> This problem can also be solved by changing a generic PowerDesigner setting by performing the following steps:
> 1. Go to 'Tools' in the main menu and choose 'General Options...'
> 1. In the 'General Options' screen go to the 'Dialog' section.
> 1. For the 'Operating modus' enable 'Auto commit'.
>
> Note that the 'OK', 'Cancel' and 'Apply' buttons will disappear from every screen and a 'Close' button will appear. Reverting a change can be done using the 'Undo' functionaly (Edit -> Undo or CTRL+Z).

## Is there a way to debug the extension?

When developing the extension we added writing extra debugging information to the 'Script' output window. This debugging information is only writting to the output when MDDE_DEBUG_MODE is enabled. To enable/disable debug mode, please follow the following steps:

1. Go to 'Tools' in the main menu and choose 'General Options...'.
1. In the 'General Options' screen go to the 'Variables' section.
1. Add a new variable with the name 'MDDE_DEBUG_MODE' (if it doesn't exist yet).
1. Set the 'Value' for this variable to 'True' when you want debug mode enabled or the 'False' when you want it disabled. If the variable doesn't exist debug mode will be disabled by default.

![Extension debug mode](img\extension_debug_mode.png)

[Go back to main modeling page](./README.md)