# SuiteCRM Customization: Module Builder vs. Studio

SuiteCRM provides two powerful tools for extending and customizing your CRM instance: **Module Builder** and **Studio**. Understanding their distinct roles is crucial for efficient, maintainable, and upgrade-friendly customization.

## Module Builder

**Purpose:** Primarily used for **creating entirely new custom modules and their underlying database tables.**

### When to Use It:
* You need a completely new, distinct business object that doesn't fit into existing SuiteCRM modules (e.g., a "Projects" module, an "Assets" tracker, or a "Support Tickets" system).
* You are defining the initial structure, core fields, and primary relationships for a brand-new entity within SuiteCRM.

### Key Features:
* Define a module's name, singular and plural labels, and module type (e.g., Basic, Company, Person).
* Add initial fields (e.g., text, number, date, dropdowns, checkboxes).
* Establish relationships between your new module and existing modules (e.g., "One-to-Many" with Accounts, "Many-to-Many" with Contacts).
* Design the initial layouts for **DetailView**, **EditView**, **ListView**, and **SearchView**.
* Create **packages** to group multiple custom modules, allowing for easy export and import as `.zip` files.
* The **"Deploy"** action generates the necessary database tables and core module files within the `custom/` directory of your SuiteCRM installation.

### Workflow:
1.  Navigate to `Admin > Developer Tools > Module Builder`.
2.  Click "New Module" (or "New Package" if bundling multiple modules).
3.  Define the module's properties (name, type).
4.  Add initial **Fields** and **Relationships** via the left-hand menu.
5.  Design the required **Layouts** by dragging and dropping fields.
6.  Click **"Deploy"** for your module/package.
7.  Go to `Admin > Repair > Quick Repair and Rebuild` (essential for changes to take effect).

**Important Note:** After a module has been deployed from Module Builder, it's generally recommended to use **Studio** for any subsequent modifications to that module to avoid potential conflicts if you were to re-deploy from Module Builder.

## Studio

**Purpose:** Used for **modifying and refining existing modules**, encompassing both stock (out-of-the-box) SuiteCRM modules (e.g., Accounts, Contacts, Leads, Opportunities) and any custom modules you've created via Module Builder.

### When to Use It:
* Adding new custom fields to an existing module (e.g., a "Customer Tier" dropdown to the "Accounts" module).
* Modifying the display layouts (**DetailView**, **EditView**, **ListView**, **SearchView**) of any existing module.
* Creating or managing relationships between existing modules (e.g., adding a new relationship between Calls and your custom "Projects" module).
* Customizing dropdown lists, field labels, module labels, and subpanels for any existing module.

### Key Features:
* Intuitive drag-and-drop interface for rearranging fields and panels on layouts.
* Direct creation and editing of custom fields within the context of an existing module.
* Management of existing relationships and creation of new ones.
* Ability to customize dropdown lists used by fields.
* Direct editing of module and field labels.

### Workflow:
1.  Navigate to `Admin > Developer Tools > Studio`.
2.  Select the **module** you wish to customize from the module list (e.g., "Accounts", or your previously deployed "Projects" module).
3.  Navigate to "Fields," "Layouts," "Relationships," or "Labels" within the selected module's options.
4.  Make your desired changes.
5.  Go to `Admin > Repair > Quick Repair and Rebuild` (essential after most changes to clear cache and apply database updates).

## Best Practice Workflow Summary

To ensure a stable, flexible, and upgrade-friendly customization strategy for your SuiteCRM instance, follow this recommended workflow:

1.  **Initial Module Creation:** Use **Module Builder** once to define and deploy the foundational structure of any **brand-new custom module**.
2.  **Ongoing Customization:** For all subsequent modifications (adding more fields, relationships, adjusting layouts, labels) to ***any*** module (including your newly created custom module and all stock modules), use **Studio**.
3.  **Repair and Rebuild:** Always run `Admin > Repair > Quick Repair and Rebuild` after any significant customization in either Module Builder or Studio to ensure changes are fully applied and the system cache is synchronized.

---