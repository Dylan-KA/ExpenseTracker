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
                Text("Overview")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(20)
            
            Spacer()
            
            Chart(expenseViewModel.totalExpensesByCategory()) { expense in
                SectorMark(
                    angle: .value("Total", expense.totalAmount),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.0
                )
                .foregroundStyle(by: .value("Category", expense.category))
            }
            .chartLegend(.visible)
            .frame(height: 500)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SummaryView(expenseViewModel: ExpenseViewModel())
}
