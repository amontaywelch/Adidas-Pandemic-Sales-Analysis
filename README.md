# Adidas-Pandemic-Sales-Analysis

Table of Contents

 - Project Overview
 - Executive Summary
 - Delving Into Insights
   - Sales Trends and Growth Rates
   - Regional Classification
   - Regional Performance
   - Product Effectiveness Metrics
   - Sales Methods and Retailers
 - Recommendations
 - Key Stakeholder Questions, Data Limitations and Assumptions
----
## Project Overview
Adidas, the renowned German sportswear giant recognized worldwide by its iconic 'Three Stripes' logo, partners with various retailers across the United States to expand its reach and drive profitability. However, the onset of COVID-19 in 2020 drastically reshaped the retail landscape. Mandated lockdowns and social distancing measures led to significant disruptions, forcing many businesses to adapt to sudden changes—or face financial losses and potential closure.

This project aims to analyze the impact—both positive and negative—of the pandemic's first two years on Adidas' retail sales. By collaborating with the sales and marketing teams, I will partner with the head of sales and marketing to extract valuable insights and provide actionable recommendations to enhance marketing efforts and drive sales growth in a post-pandemic world.

## Excecutive Summary
This analysis examines nearly 10,000 sales records from January 1, 2020, to December 31, 2021, revealing total revenue of approximately $900 million. Men's Street Footwear emerged as the leading product category, contributing 23.21% of total revenue. A significant shift toward e-commerce was observed, with online sales accounting for 50.7% of total revenue, surpassing in-store sales, which represented 49.3%.

To capitalize on these findings, Adidas should prioritize investments in online platforms, such as websites and mobile apps, to better serve customers who cannot access brick-and-mortar stores. Additionally, focusing on high-performing categories like Men's Street Footwear while reevaluating underperforming products can drive sustainable growth and strengthen market presence in the post-pandemic era.

![Adidas Sales ERD](Data/Visualizations/sales_erd.png)


Adidas Sale Dataset ERD

## Delving Into Insights
### Sales Trends and Growth Rates

 - Adidas generated nearly $900M in revenue from 01/01/2020 to 12/31/2021, with 9,648 recorded invoices. 
 - Sales increased exponentially during 2021 by 294%, rising from $182.1M to $717.8M.
 - Profit increased from $63.4M in 2020 to $268.8M in 2021, a 324.1% increase. Profit growth outpaced revenue growth, suggesting improved efficiency or higher-margin products in 2021.
   - #### 2020 Trends
     - April ($24.6M) and August ($19.9M) were strong months for revenue, possibly due to events or promotional campaigns.
     - June, November, and December showed significant drops in revenue and profit, likely driven by seasonal or external factors like COVID-19 restrictions.
     - The sharp decline in June (-45.68% revenue, -60.67% profit, -66.34% units sold) stands out. This could be linked to supply chain disruptions or reduced demand.
     - Reduced sales in November and December (-46.95% to -50.62% revenue, respectively) suggests missed opportunities during the holiday season.

   - #### 2021 Trends
     - With steady growth in revenue and profit from January to July, the recovery from the previous year is distinctly noticable
     - July and August stand out as peak months in 2021, with revenue exceeding $78.3M and $72.3M, respectively.
     - December 2021 saw a significant revenue increase ($77.8M, +40.91% YoY) compared to December 2020.
     - November saw a slight dip in units sold despite an increase in revenue, suggesting higher average pricing or premium product sales.

   
![Sales Trends 2020](Data/Visualizations/2020_sales_trends.png)
![Sales Trends 2021](Data/Visualizations/2021_sales_trends.png)

![Monthly Trend Metrics](Data/Visualizations/python_metric1.png)
![Monthly Growth Metrics By Year](Data/Visualizations/python_metric2.png)

## Regional Classification
Each state was classified into a region, with there being 5 regions in total. Below is each region and which states are present:
 - **West**: Washington, Oregon, California, Alaska, Hawaii, Idaho, Montana, Nevada, Utah, Wyoming, Colorado
 - **Southwest**: Arizona, New Mexico, Oklahoma, Texas
 - **Midwest**: North Dakota, South Dakota, Nebraska, Kansas, Missouri, Iowa, Minnesota, Wisconsin, Illinois, Indiana, Michigan, Ohio
 - **Northeast**: Maryland, Delaware, Pennsylvania, New Jersey, New York, Connecticut, Rhode Island, Massachusetts, Vermont, New Hampshire, Maine
 - **Southeast**: Virginia, West Virginia, Tennessee, Kentucky, Arkansas, Louisiana, Mississippi, Alabama, Florida, North Carolina, South Carolina, Georgia

## Regional Performance
 - The Southeast region slightly edged out the West region as best performing, accounting for 29% of total revenue. West accounted for 28% of the total revenue.
 - Understandibly, the Southwest region was the least performing region, due to only having four states present. With such a small area, this region can be zeroed in on to allocate targeted marketing strategies towards areas of more dense populations, such as Texas and Arizona.
 - The Southeast region is the only one to cross the $1M profit threshold from 2020-2021. Florida is a key state in this region as the most populated, which can help drive sales if consumer engagement is high.

![Regional Trends](Data/Visualizations/regional_trends.png)

## Product Effectiveness Metrics
 - Men's Street Footwear is the most popular product category in 2020 and 2021, accounting for around $208M(23% of total revenue) of the total revenue generated. Women's Apparel is second with $179M(about 20% of total revenue) of the total revenue generated.
 - Men's products generated $486M(54% of total revenue), compared to $413M(46% of total revenue) from Women's products.
 - Women's Athletic Footwear was the bottom performing product category, bringing in around $106M(12% of revenue). Yet it sold more than 11K total units than Men's Apparel, which accrued around $17M more in revenue. Reasons behind this could include a lower price per unit cost, or markups on products to mirror competitor pricing.

![Product Performance](Data/Visualizations/product_performance.png)

## Sales Methods and Retailers
 - West Gear leads with 27% of the total sales ($242.9M), making it the top performer in sales volume. Foot Locker is close behind with 24.5% ($220.1M), and Sports Direct follows with 20.3% ($182.5M).
 - Amazon and Walmart contribute the least, with 8.6% ($77.7M) and 8.3% ($74.6M) of total sales, respectively.
 - West Gear maintains the highest profit contribution, with 25.8% of the total profit ($85.7M), although its sales percentage (27%) is slightly higher than its profit percentage.
 - Sports Direct has a higher profit percentage (22.4%) relative to its sales percentage (20.3%), indicating better profitability on each sale.
 - West Gear has $136.5 in profit per unit sold ($85,667,968 / 625,262), making it the most efficient in terms of profitability per unit.
 - West Gear also leads in units sold, contributing 25.2% of the total units (625K). Foot Locker follows closely with 24.4% (604K).

![Retailer Performance](Data/Visualizations/retailer_performance.png)

 - In-store sales account for 72.5% of the total sales ($652.2M), significantly outpacing online sales, which contribute 27.5% ($247.7M). Despite the larger portion of sales coming from in-store, online sales still represent a significant share of the overall sales at nearly 28%.
 - In-store operations contribute 70.9% of total profits ($235.6M), reflecting its dominance in overall sales. Online sales contribute a higher proportion of profits (29.1% or $96.6M) compared to its share of total sales (27.5%). This indicates that online sales are more profitable on a per-dollar basis.
 - In-store sales account for 62.1% of the total units sold (1.5M), while online sales make up 37.9% (939K). Despite a larger share in total sales, in-store sales have a lower share of total units sold, meaning in-store purchases may involve higher-ticket items on average.
 - Online Sales show a higher profit-per-unit ratio. The profit per unit sold online is approximately $102.7 ($96,555,337 / 939,093 units), which is higher than the profit-per-unit for in-store sales, which is around $153.7 ($235,579,785 / 1,539,768 units). This suggests that while online sales are more profitable per unit sold, in-store sales bring in a higher total profit due to the volume of purchases.

![Sale Method Performance](Data/Visualizations/sale_methods.png)

# Recommendations
Maximizing High-Growth Regions and Categories
 - **Southeast Focus**: Scale up marketing efforts and regional promotions to strengthen dominance.
 - **West Optimization**: Introduce premium product lines or bundles to increase average order value and improve profitability.
---
Target Growth in Underperforming Regions
 - **Southwest Strategy**: Adjust pricing to improve margins and run region-specific promotions to attract high-value customers.
 - **Midwest Focus**: Highlight practical or essential products with targeted campaigns to align with customer demand.
---
Optimize Product Category Offerings
- **Focus on Best Sellers**: Prioritize Men’s Street Footwear and Women’s Apparel for inventory and promotions due to their leading contributions.
- **Grow Niche Categories**: Promote Athletic Footwear (both men’s and women’s) with fitness-focused campaigns and influencer partnerships.
---
Leverage Seasonality and Trends
- **Seasonal Sales Optimization**:
  - January, March, and December show peak performance historically. Align major campaigns with these times.
  - Use slow months (e.g., June, October) for clearance sales to move inventory and prepare for peak periods.
- **Athletic Footwear**: Leverage New Year fitness resolutions and back-to-school periods for targeted promotions in this category.
---
Capitalize on Channel Opportunities
- **In-Store Dominance**:
  - In-store sales account for over 72% of revenue. Invest in enhancing the in-store experience:
  - Introduce exclusive in-store promotions.
  - Train staff to upsell and cross-sell complementary products.
- **Online Growth Potential**:
  - Online sales contribute 27.5% of revenue but represent a growing share of units sold (37.9%).
  - Improve the online experience with targeted ads, user-friendly design, and personalized recommendations.
  - Offer exclusive online bundles to drive higher basket sizes.
 ---
 # Key Stakeholder Questions, Data Limitations and Assumptions
 ## Questions for Stakeholder(s)
  - Information about the `city` column
    - What context does each city carry? Is it meant to show the most populous city in each state, or the city with the biggest market?
  - Skew of Data
    - There are missing invoice dates for some retailers. What could've caused this, and how do we go about the rest of the project?
  - Primary Objectives
    - What is the overall goal of this analysis? Is it to understand how well performance is during a global event? Market expansion?
  - Metric Prioritization
    - Are there any specific regions, products, or any other metric that require more attention?
  - Defining Success
    - How will success be measured for this project, and how will potential challenges and caveats be managed to ensure we stay on track?

 ## Data Limitations and Assumptions
 **Missing Data**
   - **Description**: 36.3% of the data is currently missing, which represents a significant portion of the dataset. This missing data could lead to inaccurate representations of performance across different time periods, regions, and product categories.
   - **Implications**: The gaps in the data may skew our understanding of sales trends, potentially affecting strategic decisions such as budgeting, forecasting, and market expansion. Incomplete data may also lead to biased insights, especially when comparing regions or products.

 **Purpose of `city` column**
   - **Description**: The city column in the dataset needs further clarification. It’s important to understand the intended use of this column to ensure we are leveraging it effectively.
   - **Implications**: Without a clear understanding of how the city data should be interpreted, we may miss opportunities to identify regional market hotspots. Establishing the purpose of this column will guide how we can use it to target specific geographic regions for market expansion or tailored marketing campaigns.

 **Incomplete Segmentation and Market Insights**
   - **Description**: The missing data for certain regions, time periods, and product categories limits our ability to fully segment the market and understand regional preferences and trends.
   - **Implications**: These gaps could prevent us from identifying high-performing areas or products that require more attention or investment. It also makes it harder to develop targeted marketing strategies or assess performance for underrepresented segments.

 **Temporal Gaps in Data**
   - **Description**: Certain time periods (e.g., specific months or quarters) may be missing from the dataset, particularly during high-sales times.
   - **Implications**: Missing data for critical time periods (like holidays or seasonal peaks) could distort overall performance metrics. This might lead to inaccurate trend analysis and forecasting, which could affect future planning and decision-making.
--- 
 
   





   










