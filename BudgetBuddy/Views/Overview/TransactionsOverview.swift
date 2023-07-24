//
//  TransactionsOverview.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/17/23.
//

import SwiftUI

struct TransactionsOverview: View {
    @State private var addTransaction = false
    @State private var selectedPoint: (String, Double)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        // MARK: Title
                        Text("Overview")
                        
                        // MARK: Add/Remove Transaction
                        Spacer()
                        Label("", systemImage: "minus.circle")
                        Button {
                            addTransaction.toggle()
                        } label: {
                            Label("", systemImage: "plus.circle")
                        }
                        .sheet(isPresented: $addTransaction ) {
                            NavigationView {
                                NewTransaction()
                                    .navigationBarItems(trailing: Button(action: {
                                        addTransaction.toggle()
                                    }) {
                                        Image(systemName: "x.circle")
                                            .foregroundColor(.black)
                                    })
                            }
                        }
                        
                    }
                    .font(.title2)
                    .bold()
                    
                    
                    // MARK: SwiftUICharts
                    //Swift Package: https://github.com/AppPear/ChartView
//                    let data = transactionListVM.accumulateTransactions()
//
//                    if !data.isEmpty {
//                        let totalExpenses =  data.last?.1 ?? 0
//
//                        CardView() {
//                            VStack(alignment: .leading) {
//                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
//                                LineChart()
//                            }
//                            .background(Color.systemBackground)
//                        }
//                        .data(data)
//                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
//                        .frame(height: 300)
//                    }
                    
                    // MARK: Chart
                    RecentActivityChart()
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct TransactionsOverview_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions =  transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            TransactionsOverview()
            
            TransactionsOverview()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
