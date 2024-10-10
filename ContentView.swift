//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import SwiftUI

class TabSelectionManager: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct ContentView: View {
    
    @StateObject var tabSelectionManager = TabSelectionManager()

    
    var body: some View {
            
        TabView(selection: $tabSelectionManager.selectedTab) {
            SummaryView(expenseViewModel: ExpenseViewModel())
                .environmentObject(tabSelectionManager)
                .tabItem {
                    Label("Overview", systemImage: "house.fill")
                }
                .tag(0)
            
            AddExpenseView(expenseViewModel: ExpenseViewModel())
                .environmentObject(tabSelectionManager)
                .tabItem {
                    Label("Add Expense", systemImage: "plus.app.fill")
                }
                .tag(1)

            ExpenseListView(expenseViewModel: ExpenseViewModel())
                .environmentObject(tabSelectionManager)
                .tabItem {
                    Label("Expenses", systemImage: "dollarsign.square.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
