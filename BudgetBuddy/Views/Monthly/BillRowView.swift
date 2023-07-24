//
//  BillRowView.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/19/23.
//

import SwiftUI

struct BillRowView: View {
    let bill: MonthlyBill
    var onTap: (() -> Void)? = nil //Closure to handle onTap action
    var onDelete: (() -> Void)? = nil
    @EnvironmentObject var viewModel: MonthlyBillsViewModel
    @Binding var editableBillIndex: Int?
    @Binding var showEditSheet: Bool
    
    // Helper function to determine the text color based on the due date
    private func dueDateTextColor(for dueDate: Date) -> Color {
        let currentDate = Date()
        if Calendar.current.isDate(dueDate, inSameDayAs: currentDate) {
            // If the due date is the same as the current date, set the text color to orange
            return .orange
        } else if dueDate < currentDate {
            // If the due date is before the current date, set the text color to red
            return .red
        } else {
            // For any other case, use the default color (.secondary)
            return .secondary
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(bill.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                if bill.isPaid {
                    Text("Paid")
                        .foregroundColor(.secondary)
                } else {
                    Text("Due on \(bill.dueDate.formattedDate())")
                        .foregroundColor(dueDateTextColor(for: bill.dueDate))
                }
            }
            Spacer()
            if let onTap = onTap {
                Button(action: {
                    onTap()
                }) {
                    if bill.isPaid {
                        Image(systemName: "checkmark.square.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "square")
                            .foregroundColor(.primary)
                    }
                }
            }
            
            if viewModel.editableBillIndex == viewModel.monthlyBills.firstIndex(where: { $0.id == bill.id }) {
                Button(action: {
                    viewModel.editableBillIndex = nil //Clear editableBillIndex to hide the edit sheet
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Button(action: {
                    viewModel.editableBillIndex = viewModel.monthlyBills.firstIndex(where: { $0.id == bill.id }) //Set editableBillIndx to show the edit sheet
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if let onDelete = onDelete {
                Button(action: {
                    onDelete()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
struct BillRowView_Previews: PreviewProvider {
    static var previews: some View {
//        BillRowView()
        Text("Hello World")
    }
}
