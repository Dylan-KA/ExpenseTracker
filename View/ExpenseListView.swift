//
//  ExpenseListView.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case date = "Date"
    case priceLowToHigh = "Price Lowest"
    case priceHighToLow = "Price Highest"
    case alphabetical = "Alphabetical"
    case category = "Category"
    
    var id: String { self.rawValue }
}

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
            .padding(.horizontal)
            
            // Total
            HStack {
                Text("Total Spent: $\(expenseViewModel.totalSpent, specifier: "%.2f")")
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
            .padding()
            
            // Sorting Drop-down Picker
            HStack {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .padding(.horizontal, 10)
                    Text("Sort by")
                        .bold()
                    Spacer()
                    Picker("Sort by", selection: $expenseViewModel.sortOption) {
                        ForEach(SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(height: 38)
                    
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                Spacer()
            }
            
            // List
            List(expenseViewModel.expenses) { expense in
                VStack {
                    HStack {
                        Text(expense.title)
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text("$\(expense.amount, specifier: "%.2f")")
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
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .frame(height: 550)
            Spacer()
        }
    }
}


#Preview {
    ExpenseListView(expenseViewModel: ExpenseViewModel())
}
