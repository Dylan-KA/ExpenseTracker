//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalSpent: Double = 0.0
    @Published var sortOption: SortOption = .date
    
    private var coreDataManager = CoreDataManager.shared

    init() {
        loadExpenses()
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        coreDataManager.saveExpense(expense)
        calculateTotalSpent()
    }

    func deleteExpense(_ expense: Expense) {
        coreDataManager.deleteExpense(expense)
        loadExpenses()
    }

    func loadExpenses() {
        expenses = coreDataManager.fetchExpenses()
        calculateTotalSpent()
    }

    func calculateTotalSpent() {
        totalSpent = expenses.reduce(0) { $0 + $1.amount }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }


}

