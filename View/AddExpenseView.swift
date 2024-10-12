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
    @State private var category: String = "none"
    
    let categories = ["Food", "Entertainment", "Transportation", "Shopping", "Utilities", "Other"]
    
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Track New Expense")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(20)
            
            // Choose Category Button
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Picker("Category", selection: $category) {
                Text("Category").tag("none")
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)
            .frame(height: 38)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
                      
            Spacer()
            
            // Add Expense Button
            Button("Add Expense") {
                if let amountDouble = Double(amount), category != "none" {
                    let newExpense = Expense(title: title, category: category, amount: amountDouble, date: Date())
                    expenseViewModel.addExpense(newExpense)
                    title = ""
                    amount = ""
                    category = "none"
                }
            }
            .foregroundColor(.white)
            .font(.title2)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color.blue)
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.vertical, 50)
        }
    }
}


#Preview {
    AddExpenseView(expenseViewModel: ExpenseViewModel())
}
