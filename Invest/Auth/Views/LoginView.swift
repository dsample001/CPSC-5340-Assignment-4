//
//  LoginView.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import SwiftUI
import Combine
import FirebaseAnalytics

private enum FocusableField: Hashable {
    case email
    case password
}


struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailPassword() {
        Task {
            if await viewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "at")
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $viewModel.password)
                    .focused($focus, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        signInWithEmailPassword()
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 8)
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color(UIColor.systemRed))
                }
            }
            
            Button(action: signInWithEmailPassword) {
                if viewModel.authenticationState != .authenitcating {
                    Text("Login")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModel.isValid)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            
            HStack {
                Text("Don't have an account yet?")
                Button(action: { viewModel.switchFlow() }) {
                    Text("SIgn up")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding([.top, .bottom], 50)
            
        }
        .listStyle(.plain)
        .padding()
        //.analyticsScreen(name: "\(Self.self)")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
            LoginView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}

