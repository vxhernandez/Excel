Excel file was imported into SQL server.
Further cleaning and transformation was performed once the data was imported into the database.

- **BrokerTitle Column**:
    - Standardized broker titles by converting all entries from uppercase to proper case for consistency and readability.
- **Type Column**:
    - Extracted sale type information (e.g., "For Sale," "Pending") from the Type column and moved it to a new column named SaleType.
    - Retained only property type information (e.g., "Condo," "Townhouse") in the Type column.
- **City, Locality, Sublocality, and Neighborhood Columns**:
    - Corrected inconsistencies and inaccuracies in these columns to align with their intended definitions:
        - **City**: Represents the overarching city (e.g., "New York City").
        - **Locality**: Represents the borough (e.g., "Manhattan," "Queens").
        - **Sublocality**: Represents specific areas within a borough (e.g., "Flushing").
        - **Neighborhood**: Refers to smaller, more localized regions (e.g., "Astoria").
    - Ensured consistent naming conventions and resolved incorrect assignments.
