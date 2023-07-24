//
//  RecentActivityChart.swift
//  BudgetBuddy
//
//  Created by Bryan Tacuri on 7/17/23.
//

import SwiftUI
import Charts

struct RecentActivityChart: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        //Test Data
//        let data2: [accumulateTransaction] = [
//            .init(date: "Jul 4, 2023".dateParsed(), amount: 500.00),
//            .init(date: "Jul 5, 2023".dateParsed(), amount: 150.00),
//            .init(date: "Jul 6, 2023".dateParsed(), amount: 250.00),
//            .init(date: "Jul 7, 2023".dateParsed(), amount: 100.00),
//            .init(date: "Jul 8, 2023".dateParsed(), amount: 350.00),
//            .init(date: "Jul 9, 2023".dateParsed(), amount: 50.00),
//            .init(date: "Jul 10, 2023".dateParsed(), amount: 500.00),
//        ]
        
        let data = transactionListVM.accumulateTransactions()
        
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    Color.icon.opacity(0.4),
                    Color.icon.opacity(0.0)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        VStack {
            Text("Recent Activity")
                .bold()
        
            if !data.isEmpty {
                let totalExpenses =  data.last?.1 ?? 0
                Text(totalExpenses.formatted(.currency(code: "USD")))
                    .foregroundColor(.secondary)
            }
            Chart(data, id: \.0) { transaction in
                
                LineMark(
                    x: .value("Date", transaction.0),
                    y: .value("Amount", transaction.1)
                )
                .foregroundStyle(Color.icon)
                
                
                PointMark(
                    x: .value("Date", transaction.0),
                    y: .value("Amount", transaction.1)
                )
                .foregroundStyle(Color(red: 0.28, green: 0.658, blue: 0.942))
                
                AreaMark(
                    x: .value("Date", transaction.0),
                    y: .value("Amount", transaction.1)
                )
                .foregroundStyle(curGradient)
            }
            .chartXAxis(Visibility.hidden)
//                        .chartXAxisLabel("Date")
//                        .chartYAxisLabel("Amount")
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .frame(height: 300)
    }
}

struct RecentActivityChart_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions =  transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            RecentActivityChart()
            
            RecentActivityChart()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
