//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // MARK: - Core Data Stack
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ExpenseTrackerModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    // MARK: - Save Expense
    func saveExpense(_ expense: Expense) {
        let context = persistentContainer.viewContext
        
        let expenseEntity = ExpenseEntity(context: context)
        expenseEntity.id = expense.id
        expenseEntity.title = expense.title
        expenseEntity.category = expense.category
        expenseEntity.amount = expense.amount
        expenseEntity.date = expense.date
        
        do {
            try context.save()
        } catch {
            print("Failed to save expense: \(error)")
        }
    }
    
    // MARK: - Fetch Expenses
    func fetchExpenses() -> [Expense] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        
        do {
            let expenseEntities = try context.fetch(fetchRequest)
            return expenseEntities.map { expenseEntity in
                Expense(id: expenseEntity.id ?? UUID(),
                        title: expenseEntity.title ?? "",
                        category: expenseEntity.category ?? "",
                        amount: expenseEntity.amount,
                        date: expenseEntity.date ?? Date())
            }
        } catch {
            print("Failed to fetch expenses: \(error)")
            return []
        }
    }
    
    // MARK: - Delete Expense
    func deleteExpense(_ expense: Expense) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", expense.id as CVarArg)
        
        do {
            let expenseEntities = try context.fetch(fetchRequest)
            if let expenseEntityToDelete = expenseEntities.first {
                context.delete(expenseEntityToDelete)
                try context.save()
            }
        } catch {
            print("Failed to delete expense: \(error)")
        }
    }
}

