> [Manual](./README.md) > Configure the XML export

# Model Export Configuration

The XML export of the MDDE extension can be configured to include/exclude certain information. These configuration properties are available on model level. You can access the configuration by right-clicking on the model, and click on 'Properties'. In the new dialog window go the the 'XML Export (MDDE)' tab.

![Model export configuration](img/model_export_config.png)

On this tab you can tick the boxes for the metadata which you want to include in the XML export.

> **Note**:
> If you have multiple models and want to keep these settings in sync, it's adviced to create a model check for you project/organisation (in a project/organisation specific extension) to check and autofix these settings.



## Export options
The options are described in the table below.

| Option                                                 | Description |
|---                                                     |---          |
| SourceObject `<<ExpressionBusinessRule>>` SQL Expression | Indicator whether to include the resolved SQL expression of expression business rules (like scalar and filter) in the XML export of source objects. |