> [Modeling](./README.md) > Business rule

# Business rule

In order to model business rules new object types are introduced using the extension (based on the Entity type). If you are in a diagram of a model where the 'Data Warehouse Automation' extensions is attached, in the Toolbox on the right a section for this extension will be available for creating business rules.

![PowerDesigner Toolbox Business Rule](img\business_rule_toolbox.png)

In order to create a business rule you can click on any business rule icon in the Toolbox in the 'Data Warehouse Automation (MDDE)' section. Hover over the icon to see what each icon represents. When you have clicked an icon the Toolbox you can click in the diagram where you want to have the business rule positioned. To stop creating business rules in the diagram, press the right-click button of the mouse. After you have create a scalar business rule in the diagram you can double click to edit it. Specifics about each business rule type are explained in their respective section:

## Scalar business rule

A scalar business rule is a business rule which can have one or more inputs (parameters) and only one output. These types of business rules are idempotent, meaning that it will always return the same result given identical input. This also means these types of business rules don't consume any more input then it's input attributes. Furthermore the logic of the business rule is functionally described and technically implemented using a SQL expression.

Go through the following steps to model the scalar business rule:

### General

On the 'General' tab:

1. Set the Name of the scalar business rule. This must be a short functional name which makes clear what the purpose of the rule is. The Code of the rule is automatically populated based on the Name you have entered.
1. Functionally describe the business rule in the 'Comment' field.
1. Write the SQL syntax for the business rule in the 'SQL Expression (MDDE)' field. The expression should contain one or multiple scalar SQL expressions seperated by a comma. For example `CASE WHEN ... THEN ... ELSE ... END AS EXAMPLE_OUTPUT` or `LEFT(..., ...) AS LEFT_OUTPUT`. Don't include any set operation like SELECT, JOIN, GROUP BY or somesort. You must include the output alias of the expression (like ` AS RESULTING_VALUE`) the output alias must match the 'Code' of an attribute of the business rule with the stereotype 'Output attribute (MDDE)'. When you want to reference an input of the business rule in the SQL expression you must use the 'Code' of the input attribute as specified on the 'Attributes' tab (see below for explanation on adding these attributes). For example, when you have an input attribute with the Name 'Example Input' it's Code will be 'EXAMPLE_INPUT' and an example SQL expression can be `LEFT(EXAMPLE_INPUT, 2) AS EXAMPLE_OUTPUT`.

![Scalar business rule - General](img\scalar_business_rule_general.png)

> Preferably use ANSI SQL syntax since it makes the expression re-usable when migrating to a different database platform.


### Attributes

On the 'Attributes' tab:
1. Add each input of the rule as an attribute, set it's data type and set the Stereotype to 'Input attribute (MDDE)'
1. Add the output of the rule as an attribute, set it's data type and set the Stereotype to 'Output attribute (MDDE)'

![Scalar business rule - Attributes](img\scalar_business_rule_attributes.png)

> Note: the name of the input and output attributes need to be functional so it's clear what input is expected and what the output means.

> If you don't see the 'Stereotype' field in the Attributes list, you can add it using the 'Customize Columns and Filter' toolbar button.

### Examples

As part of specifying business rules it's important to also include examples. An example contains the expected output given an example input for the scalar business rule. To model an example following the following steps:

On the 'Examples (MDDE)' tab:
1. Click on the 'Add example' button. This will create a new empty example and pre-populate the input and output lists with the attributes modelled in the scalar business rule.
2. Set the 'Name' of the example so it's clear what scenario it resembles.
3. Set the values for the input attributes in the 'Input' section.
4. Set the values for the expected output in the 'Output' section.
5. (Optionally) Descrive the scenario in the 'Comment' field.
6. Press 'Apply' to store the scenario.

When you want to create multiple examples, follow the the above steps for every example.

![Scalar business rule - Examples](img\scalar_business_rule_examples.png)

## Filter business rule

A filter business rule is a rule with which one can filter a dataset from within a mapping. It can have one or more inputs and it should contain a Sql Expression which can be evaluated as a condition (boolean). Only records from the mapping where the result of the expression is true will be returned.

> A filter business rule can only be applied on the whole resultset of a mapping. This means it can't be used to filter a single source object within a mapping. For the latter the filter condition should be part of the source object join conditions.

Go through the following steps to model the filter business rule:

### General

On the 'General' tab:

1. Set the Name of the filter business rule. This must be a short functional name which makes clear what the purpose of the filter is. The Code of the rule is automatically populated based on the Name you have entered.
1. Functionally describe the business rule in the 'Comment' field.
1. Write the SQL syntax for the filter in the 'SQL Expression (MDDE)' field. The expression should contain one SQL condition (it should be true or false). For example `FIRST_INPUT > SECOND_INPUT` or `FIRST_INPUT <> SECOND_INPUT AND FIRST_INPUT > 0`. Don't include any set operation like SELECT, JOIN, GROUP BY or somesort. Also don't include the output alias of the expression (like ` AS RESULTING_VALUE`). When you want to reference an input of the business rule in the SQL expression you must use the 'Code' of the input attribute as specified on the 'Attributes' tab (see below for explanation on adding these attributes). For example, when you have an input attribute with the Name 'Example Input' it's Code will be 'EXAMPLE_INPUT'.

![Filter business rule - General](img\filter_business_rule_general.png)

### Attributes

On the 'Attributes' tab:
1. Add each input of the rule as an attribute, set it's data type and set the Stereotype to 'Input attribute (MDDE)'

![Scalar business rule - Attributes](img\filter_business_rule_attributes.png)

### Examples

As part of specifying business rules it's import to also include examples. An example contains the expected filter result given an example input for the filter business rule. To model an example following the following steps:

On the 'Examples (MDDE)' tab:
1. Click on the 'Add example' button. This will create a new empty example and pre-populate the input lists with the attributes modelled in the filter business rule.
2. Set the 'Name' of the example so it's clear what scenario it resembles.
3. Set the values for the input attributes in the 'Input' section.
4. Set the value for the expected filter result in the 'Output' section. 'Yes' means the record will be included and 'No' means the records will be excluded from the resultset when applying the filter.
5. (Optionally) Descrive the scenario in the 'Comment' field.
6. Press 'Apply' to store the scenario.

When you want to create multiple examples, follow the the above steps for every example.

![Filter business rule - Examples](img\filter_business_rule_examples.png)

***

[Go back to main modeling page](./README.md)