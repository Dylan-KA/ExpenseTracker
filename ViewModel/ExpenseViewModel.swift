//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Dylan Archer on 8/10/2024.
//

import Foundation

struct ExchangeRatesResponse: Codable {
    let usd: [String: Double]
}


class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalSpent: Double = 0.0
    @Published var sortOption: SortOption = .date {
            didSet {
                sortExpenses()
            }
        }
    @Published var exchangeRate: Double = 1.0
    @Published var selectedCurrency: String = "USD" {
            didSet {
                fetchExchangeRates()
            }
        }
    
    private var coreDataManager = CoreDataManager.shared

    init() {
        loadExpenses()
        loadCurrencyPreference()
        fetchExchangeRates()
    }
    
    var currencySymbol: String {
        switch selectedCurrency {
        case "USD", "AUD":
            return "$"
        case "EUR":
            return "€"
        case "GBP":
            return "£"
        default:
            return "$"
        }
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
        totalSpent = expenses.reduce(0) { $0 + $1.amount } * exchangeRate
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    private func sortExpenses() {
        switch sortOption {
        case .date:
            expenses.sort { $0.date > $1.date }
        case .priceLowToHigh:
            expenses.sort { $0.amount < $1.amount }
        case .priceHighToLow:
            expenses.sort { $0.amount > $1.amount }
        case .alphabetical:
            expenses.sort { $0.title < $1.title }
        case .category:
            expenses.sort { $0.category < $1.category }
        }
    }
    
    // Save the selected currency in UserDefaults
    func saveCurrencyPreference(_ currency: String) {
        UserDefaults.standard.set(currency, forKey: "selectedCurrency")
    }

    // Retrieve the saved currency from UserDefaults
    func loadCurrencyPreference() {
        if let savedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") {
            selectedCurrency = savedCurrency
        } else {
            selectedCurrency = "USD"
        }
    }
    
    func fetchExchangeRates() {
        let baseCurrency = "usd" // Data in app is stored in USD
        
        guard selectedCurrency != baseCurrency.uppercased() else {
            self.exchangeRate = 1.0
            calculateTotalSpent()
            return
        }

        let urlString = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/\(baseCurrency).json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Failed to fetch rates: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                // Decode only the USD rates and ignore the date
                let decodedData = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)

                // Safely unwrap the selected currency's rate
                if let newRate = decodedData.usd[self.selectedCurrency.lowercased()] {
                    DispatchQueue.main.async {
                        self.exchangeRate = newRate
                        self.calculateTotalSpent()
                    }
                } else {
                    print("Exchange rate not found for selected currency")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
    
}

