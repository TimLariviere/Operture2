//
//  SignInView.swift
//  Operture
//
//  Created by Timothé Larivière on 24/10/2022.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    private var completion: (Bool) -> ()
    
    init(completion: @escaping (Bool) -> ()) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Operture")
                .font(.title)
            
            Spacer()
            
            Button {
                viewModel.signIn()
                completion(false)
            } label: {
                Label("Sign in with Apple", systemImage: "apple.logo")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView() { _ in () }
    }
}
