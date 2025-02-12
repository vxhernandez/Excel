
## Daily Grind Sales Insights
### An Interactive Microsoft Excel Dashboard
   
 <img src="https://github.com/vxhernandez/Excel/blob/main/Coffee_Bean_Sales_Analysis/daily_grind_sales_insights.png">

### **Project Summary**

This project analyzes coffee sales data from 2019 to 2022 to uncover key business insights and trends. Using Excel PivotTables, PivotCharts, and interactive features like Slicers and Timelines, the dashboard provides a comprehensive view of sales performance across different countries, customer segments, roast types, and time periods.

### **Objective**

The primary goal was to identify sales patterns, high-performing products, and customer behavior to support data-driven decision-making for a coffee business. This analysis helps optimize product offerings, improve customer retention, and maximize revenue potential.

### **Key Insights**

- Weekday sales consistently outperformed weekends, averaging 70.5% of total sales.
- U.S. sales were significantly higher than in the UK and Ireland.
- Loyalty program participation declined from 2019 to 2022, suggesting the need for engagement strategies.
- Friday, Saturday, and Sunday recorded the highest sales, indicating peak demand leading into the weekend.
- Liberica coffee sales spiked during winter (2021-2022), highlighting a seasonal trend.
- Light and medium roasts outperformed dark roasts among the top five customers, suggesting a preference for these flavors.

### **Process**

- Data Cleaning and Transformation
    - Standardized date formats, categorized weekday/weekend sales, and added additional data columns using IF, XLOOKUP, INDEX/MATCH.
- Interactive Data Analysis
    - Used PivotTables and PivotCharts for dynamic reporting.
    - Integrated Timelines and Slicers for easy filtering of trends over time.
- Sales Performance Visualization
    - Created sales trend graphs, country-wise comparisons, customer segmentation, and loyalty program analysis.

### **Conclusion & Recommendations**

This analysis provides valuable insights for a coffee business to refine marketing strategies, improve customer engagement, and optimize inventory based on seasonal trends. 

Key recommendations include:

- Enhancing weekend sales through targeted promotions.
- Revisiting the loyalty program to increase participation.
- Expanding light and medium roast offerings based on customer preferences.
- Leveraging seasonal demand by promoting Liberica coffee during winter.

### Data Source:

https://www.kaggle.com/datasets/saadharoon27/coffee-bean-sales-raw-dataset 

### Data Cleaning Log

- Formatted the Date Column: Changed format from 01/01/2022 to 05-May-2025 for better readability.
- Added Coffee Type & Roast Type Names: Used IF statements to generate full names for coffee type and roast type for clarity.
- Populated Key Columns: Used XLOOKUP and INDEX/MATCH to fill in Customer Name, Email, Country, Coffee Type, Roast Type, Size, Unit Price, and Sales.
- Standardized Size Format: Adjusted values from 0.5 to 0.5kg for consistency.
- Converted Data to a Table: Used Ctrl + T to format the dataset as a table, making it easier to create PivotTables.
- Added 'Day Sales' Column: Extracted the day of the week from the date to analyze daily sales trends.
- Added 'Weekend/Weekday' Column: Categorized sales as Weekend or Weekday for comparative analysis.
- Created Pivot Tables & Pivot Charts: Built visual summaries to analyze key metrics such as total sales, sales trends, and top customers.
- Inserted Timeline for Date Filtering: Added a Timeline slicer to filter data dynamically by date range.
- Inserted Slicers for Interactive Filtering: Added slicers for dimensions like Coffee Type, and Roast Type to enhance dashboard interactivity.
