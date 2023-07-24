//
//  MonthlyBillsView.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/19/23.
//

import SwiftUI

struct MonthlyBillsView: View {
    @StateObject private var viewModel = MonthlyBillsViewModel()
    @State private var showingAddBillSheet = false
    @State private var editableBillIndex: Int? = nil
    @State private var newBillName = ""
    @State private var newBillAmount = ""
    @State private var newBillNote = ""
    @State private var newBillDueDate = Date()
    @State private var showEditSheet: Bool = false
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Upcoming Bills")) {
                    ForEach(viewModel.monthlyBills.filter { !$0.isPaid }) { bill in
                        BillRowView(bill: bill, onTap: {
                            viewModel.markAsPaid(bill: bill)
                        }, onDelete: {
                            viewModel.removeBill(bill: bill)
                        }, editableBillIndex: $editableBillIndex, showEditSheet: $showEditSheet)
                        .environmentObject(viewModel) // Pass the viewModel as an environment object
                        .contextMenu {
                            Button("Edit") {
                                if let index = viewModel.monthlyBills.firstIndex(where: { $0.id == bill.id }) {
                                    editableBillIndex = index
                                    showEditSheet = true // Set showEditSheet to true to show the edit sheet
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Paid Bills")) {
                    ForEach(viewModel.monthlyBills.filter { $0.isPaid }) { bill in
                        BillRowView(bill: bill, onTap: {
                            viewModel.markAsPaid(bill: bill)
                        }, onDelete: {
                            viewModel.removeBill(bill: bill)
                        }, editableBillIndex: $editableBillIndex, showEditSheet: $showEditSheet)
                    }
                }
            }
            
            .environmentObject(viewModel)
            .navigationTitle("Monthly Bills")
            .navigationBarItems(trailing: Button(action: {
                showingAddBillSheet.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
            })
            .sheet(isPresented: $showingAddBillSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Add a Monthly Bill")) {
                            TextField("Bill Name", text: $newBillName)
                            TextField("Amount", text: $newBillAmount)
                                .keyboardType(.decimalPad)
                            DatePicker("Due Date", selection: $newBillDueDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                            TextField("Note (optional)", text: $newBillNote)
                        }
                    }
                    .navigationBarItems(leading: Button("Cancel") {
                        showingAddBillSheet.toggle() // Dismiss the sheet without saving
                        newBillName = ""
                        newBillAmount = ""
                        newBillDueDate = Date()
                        newBillNote = "" // Reset the note field
                    }, trailing: Button("Save") {
                        guard let amount = Double(newBillAmount) else { return }
                        viewModel.addBill(name: newBillName, amount: amount, dueDate: newBillDueDate, note: newBillNote)
                        showingAddBillSheet.toggle()
                        newBillName = ""
                        newBillAmount = ""
                        newBillDueDate = Date()
                        newBillNote = ""
                    })
                }
            }
        }
    }
}

struct MonthlyBillsView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyBillsView()
    }
}
