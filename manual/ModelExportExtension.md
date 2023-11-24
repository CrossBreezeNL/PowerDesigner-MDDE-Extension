> [Modeling](./README.md) > Customize the XML export

# MDDE Model Export Extension

Attach the MDDE Model Export Extension to the model and open the extension editor
![Extension is attached to the model](img/mdde_export_extension_on_model.png)

In the editor, expand the profile section in the left panel to navigate through the available metaclasses that are configured for customization. Each metaclass contains a template that can be used to include specific content to the XML Export.

The example shows a fixed xml text that is included in all objects of PowerDesigner metaclass Entity (MDDE entities, MDDE business rules). It is also possible to add custom extended attributes or content from a different extension.

![Extension editor](img/mdde_export_extension_editor.png)

The resulting XML with this example would be (only showing fragment with relevant changes):

![Extension editor](img/mdde_export_extension_result.png)

Be aware that changes that are done in the model export extension will apply to all models that have this particular instance of the extension attached. It is possible to use different variations of the model export extension for different models by saving them in different locations.

[Go back to main modeling page](./README.md)
