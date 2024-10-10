//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import Foundation

class Expense: Identifiable, Codable {
    var id: UUID
    var title: String
    var category: String
    var amount: Double
    var date: Date
    
    init(id: UUID = UUID(), title: String, category: String, amount: Double, date: Date) {
        self.id = id
        self.title = title
        self.category = category
        self.amount = amount
        self.date = date
    }
}
