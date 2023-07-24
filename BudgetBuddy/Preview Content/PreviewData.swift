//
//  PreviewData.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 6/26/23.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "06/20/2023", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
