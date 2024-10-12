//
//  SummaryView.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 10/10/2024.
//

import SwiftUI
import Charts

struct CategoryExpense: Identifiable {
    let id = UUID()
    let category: String
    let totalAmount: Double
}

extension ExpenseViewModel {
    func totalExpensesByCategory() -> [CategoryExpense] {
        let groupedByCategory = Dictionary(grouping: expenses, by: { $0.category })
        return groupedByCategory.map { category, expenses in
            CategoryExpense(
                category: category,
                totalAmount: expenses.reduce(0) { $0 + $1.amount }
            )
        }
    }
}

struct SummaryView: View {
    
    @ObservedObject var expenseViewModel: ExpenseViewModel
    
    var body: some View {
        VStack {
            
            // Title
            HStack {
                Text("Expense Tracker")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(.horizontal)
            
            // Chart
            Chart(expenseViewModel.totalExpensesByCategory()) { expense in
                SectorMark(
                    angle: .value("Total", expense.totalAmount),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.0
                )
                .foregroundStyle(colorForCategory(expense.category))
            }
            .chartLegend(.visible)
            .frame(height: 300)
            .padding()
            
            // Total
            VStack {
                HStack {
                    Text("Total Spent: $\(expenseViewModel.totalSpent, specifier: "%.2f")")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding()
            
                // Chart Legend
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(expenseViewModel.totalExpensesByCategory()) { expense in
                            HStack {
                                Circle()
                                    .fill(colorForCategory(expense.category))
                                    .frame(width: 10, height: 10)
                                
                                Text(expense.category)
                                    .font(.system(size: 16))
                                    .bold()
                                
                                Text(String(format: "$%.2f", expense.totalAmount))
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .padding()
        }
    }
}

// Function to determine color for each category
func colorForCategory(_ category: String) -> Color {
    switch category {
    case "Food":
        return .blue
    case "Entertainment":
        return .green
    case "Transportation":
        return .orange
    case "Shopping":
        return .purple
    case "Utilities":
        return .yellow
    default:
        return .gray
    }
}

#Preview {
    SummaryView(expenseViewModel: ExpenseViewModel())
}
