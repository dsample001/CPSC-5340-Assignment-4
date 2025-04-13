//
//  NewInvestDetail.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import SwiftUI

struct NewInvestDetail: View {
    
    @Binding var investment : InvestModel
    @StateObject var investApp = InvestViewModel()
    
    var body: some View {
        List {
            HStack {
                Text("Stock Symbol")
                    .fontWeight(.bold)
                Spacer()
                TextField("", text: $investment.asset)
                    .background(.yellow)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)            }
            HStack {
                Text("Number Owned: ")
                    .fontWeight(.bold)
                Spacer()
                TextField("", text: $investment.numowned)
                    .background(.yellow)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
            }
            HStack {
                Text("Current Price: ")
                    .fontWeight(.bold)
                Spacer()
                Text("$" + investment.currprice)
            }
            HStack {
                Text("Current Value: ")
                    .fontWeight(.bold)
                Spacer()
                Text("$" + investment.value)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    investApp.updateData(investment: investment)
                    investment.asset = ""
                    investment.numowned = ""
                } label: {
                    Text("Add")
                }
            }
        }
    }
}


#Preview {
    NewInvestDetail(investment: .constant(InvestModel(asset: "Stock", currprice: "1", numowned: "1", value: "1")))
}
