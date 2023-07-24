//
//  EditBillView.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/19/23.
//

import SwiftUI

struct EditBillView: View {
    @Binding var bill: MonthlyBill
    @Binding var editableBillIndex: Int?
    
    @State private var amountText: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Edit Bill")) {
                    TextField("Bill Name", text: $bill.name)
                    TextField("Amount", text: $amountText)
                        .keyboardType(.decimalPad)
                        .onChange(of: amountText) { newValue in
                            bill.amount = Double(newValue) ?? 0.0
                        }
                    DatePicker("Due Date", selection: $bill.dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    TextField("Note (optional)", text: $bill.note)
                }
            }
            Button("Save") {
                editableBillIndex = nil // Dismiss the edit sheet
            }
        }
        .onAppear {
            // Initialize the amountText with the current amount when the view appears
            amountText = String(bill.amount)
        }
    }
}

struct EditBillView_Previews: PreviewProvider {
    static var previews: some View {
//        EditBillView()
        Text("Hello World")
    }
}
