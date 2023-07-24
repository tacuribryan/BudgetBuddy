//
//  BudgetBuddyApp.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 6/26/23.
//

import SwiftUI

@main
struct BudgetBuddyApp: App {
    @StateObject var transactionsListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionsListVM)
        }
    }
}
