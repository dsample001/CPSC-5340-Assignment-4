//
//  ContentView.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var investApp = InvestViewModel()
    @State var investment = InvestModel(asset: "", currprice: "", numowned: "", value: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($investApp.investments) { $investment in
                    NavigationLink {
                        InvestDetail(investment: $investment)
                    } label: {
                        HStack() {
                            Text(investment.asset)
                            Spacer()
                            Text(investment.currprice)
                        }
                    }
                }
                Section {
                    NavigationLink {
                        // Change this to a new view, later
                        NewInvestDetail(investment: $investment)
                    } label: {
                        HStack() {
                            Text("Add New Asset")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                            Spacer()
                            Text("")
                        }
                    }
                }
            }
            .onAppear {
                investApp.fetchData()
            }
            .refreshable {
                investApp.fetchData()

            }
        }
    }
}

#Preview {
    ContentView()
}
