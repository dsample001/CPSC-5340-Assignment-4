//
//  ContentView.swift
//  Invest_2
//
//  Created by user273384 on 4/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("User Logged In!")
                Button {
                    Task {
                        viewModel.logout()
                    }
                } label: {
                    Text("Log Out")
                }
                .padding([.top, .bottom], 50)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
