//
//  ExpenseListView.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var expenseViewModel :ExpenseViewModel

    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Expenses")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(20)
            
            // Total
            HStack {
                Text("Total Spent: $\(expenseViewModel.totalSpent, specifier: "%.2f")")
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
            .padding(20)
            
            // List
            List(expenseViewModel.expenses) { expense in
                VStack {
                    HStack {
                        Text(expense.title)
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text("-$\(expense.amount, specifier: "%.2f")")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .bold()
                    }
                    HStack {
                        Text(expenseViewModel.formatDate(expense.date))
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button(action: {
                    // Trigger add new expense
                }) {
                    Text("Add")
                }
            }
        }
    }
}


#Preview {
    ExpenseListView(expenseViewModel: ExpenseViewModel())
}
