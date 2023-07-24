//
//  MonthlyBillsViewModel.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/19/23.
//

import Foundation

class MonthlyBillsViewModel: ObservableObject {
    @Published var monthlyBills: [MonthlyBill] = []
    @Published var editableBillIndex: Int? //Track the index of the bill being edited
    
    func addBill(name: String, amount: Double, dueDate: Date, note: String) {
        let bill = MonthlyBill(name: name, amount: amount, dueDate: dueDate, note: note, isPaid: false)
        monthlyBills.append(bill)
        monthlyBills.sort { !$0.isPaid && $1.dueDate > $0.dueDate }
    }
    
    func markAsPaid(bill: MonthlyBill) {
        if let index =  monthlyBills.firstIndex(where: { $0.id == bill.id }) {
            monthlyBills[index].isPaid.toggle() //Toggle the isPaid property
            monthlyBills.sort { !$0.isPaid && $1.dueDate > $0.dueDate } // Sort by isPaid first, then by dueDate
        }
    }
    
    func removeBill(bill: MonthlyBill) {
        monthlyBills.removeAll {$0.id == bill.id }
        
        //Clear the editableBillIndex if the bill being edited is removed
        if editableBillIndex == monthlyBills.firstIndex(where: {$0.id == bill.id }) {
            editableBillIndex = nil
        }
    }
}
