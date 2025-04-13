//
//  InvestDetail.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import SwiftUI

struct InvestDetail: View {
    
    @Binding var investment : InvestModel
    @StateObject var investApp = InvestViewModel()
    
    @State private var viewContentActive = false
    
    var body: some View {
        List {
            HStack {
                Text("Stock Symbol")
                    .fontWeight(.bold)
                Spacer()
                Text(investment.asset)
            }
            HStack {
                Text("Number Owned: ")
                    .fontWeight(.bold)
                Spacer()
                TextField("1.0", text: $investment.numowned)
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
            NavigationView {
                NavigationLink(isActive: $viewContentActive) {
                    ContentView()
                } label: {
                    EmptyView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    investApp.updateData(investment: investment)
                    viewContentActive = true
                } label: {
                    Text("Update")
                }
            }
        }

    }

}

#Preview {
    InvestDetail(investment: .constant(InvestModel(asset: "Stock", currprice: "1", numowned: "1", value: "1")))
}
