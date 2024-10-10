//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var expenseViewModel: ExpenseViewModel
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: String = ""
    
    let categories = ["Food", "Entertainment", "Transportation", "Shopping", "Utilities", "Other"]
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Add Expense")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(20)
            
            // Form
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
                Picker("Select a category", selection: $category) {
                    Text("None")
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                                
                Button("Add Expense") {
                    if let amountDouble = Double(amount) {
                        let newExpense = Expense(title: title, category: category, amount: amountDouble, date: Date())
                        expenseViewModel.addExpense(newExpense)
                        title = ""
                        amount = ""
                        category = ""
                    }
                }
                .bold()
            }
        }
    }
}


#Preview {
    AddExpenseView(expenseViewModel: ExpenseViewModel())
}
