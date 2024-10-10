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
        formatter.dateStyle = .medium   // You can choose different styles like .short, .long, etc.
        formatter.timeStyle = .none     // Set to .none if you don't want to show the time
        return formatter.string(from: date)
    }


}

