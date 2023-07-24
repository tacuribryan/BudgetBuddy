//
//  ContentView.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 6/26/23.
//

import SwiftUI
//import SwiftUICharts

struct ContentView: View {
    @State private var selection: Tab = .overview
    enum Tab {
        case overview
        case monthly
    }
    var body: some View {
        TabView(selection: $selection){
            TransactionsOverview()
                .tabItem{
                    Label("Overview", systemImage: "house")
                }
                .tag(Tab.overview)
            
            MonthlyBillsView()
                .tabItem{
                    Label("Monthly", systemImage: "calendar")
                }
                .tag(Tab.monthly)
        }
        .accentColor(Color.icon)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions =  transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)

    }
        
}
