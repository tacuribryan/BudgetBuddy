//
//  MonthlyBillsViewModel.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/19/23.
//

import Foundation

struct MonthlyBill: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var dueDate: Date
    var note: String
    var isPaid: Bool    //Tracks Payment status
    var editable: Bool = false
}

extension Double {
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value:self)) ?? ""
    }
}

extension Date {
    func formattedDate () -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}
