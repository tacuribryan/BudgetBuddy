//
//  TransactionListViewModel.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 6/26/23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        //https://designcode.io/data/transactions.json
        guard let url = Bundle.main.url(forResource: "transactions", withExtension: "json") else {
            print("Transaction file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let transactions = try JSONDecoder().decode([Transaction].self, from: data)
            self.transactions = transactions
        } catch {
            print("Error decoding transactions:", error.localizedDescription)
        }
    }
    
    func saveTransactions() {
        // Save transactions to the JSON file
        guard let url = Bundle.main.url(forResource: "transactions", withExtension: "json") else {
            print("Transaction file not found")
            return
        }
        
        do {
            let data = try JSONEncoder().encode(transactions)
            try data.write(to: url)
        } catch {
            print("Error encoding transactions: ", error.localizedDescription)
        }
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        
//        let today = "02/17/2022".dateParsed()
         let today = Date().description.dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum
    }
}
