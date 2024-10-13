# ExpenseTracker
 Track your expenses
 
 Repository: https://github.com/Dylan-KA/ExpenseTracker

Expense Tracker App - Documentation
1. Expense Management
• Add Expense: Users can enter new expenses by providing details such as the title,
category, amount, and the date of the expense.
• Categorize Expenses: Each expense can be categorized for easier tracking and
analysis.
• Sort Expenses: Users can sort expenses by:
o Date
o Price (Low to High)
o Price (High to Low)
o Alphabetically
o By Category
2. Currency Support
• Users can select from multiple currencies: USD, AUD, EUR, and GBP.
• The app uses real-time exchange rates to convert expenses to the selected currency.
• The app displays the total spending and individual expenses in the selected currency
along with the appropriate symbol ($, €, £).
3. Expense Visualization
• The app provides a pie chart visualization of expenses by category, helping users
understand their spending distribution.
• Users can view a legend showing the color-coded categories along with the total
amounts spent in each category.
4. Total Spending Calculation
• The app automatically calculates and displays the total amount spent based on the
currency selected by the user.
• All expenses are stored as USD, and the total amount is converted based on the
selected exchange rate for accurate display in the chosen currency.
5. Error Handling
• Data Integrity: The app validates that expenses are entered correctly, including the
amount being a positive number. Invalid or incomplete expense data is not saved.
• Currency Conversion Errors: If there is an issue with fetching the exchange rates
the app will revert to the default USD value and show an error message or use cached
data if available.
