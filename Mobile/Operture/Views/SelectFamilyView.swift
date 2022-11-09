//
//  SelectFamilyView.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import SwiftUI

struct SelectFamilyView: View {
    @StateObject private var viewModel = SelectFamilyViewModel()
    
    private var completion: () -> ()
    
    init(completion: @escaping () -> ()) {
        self.completion = completion
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Operture")
                .font(.title)
            
            Spacer()
            Spacer()
            
            Button("Join an existing family") {
                viewModel.joinFamily()
                completion()
            }
            
            Button("Create a new family") {
                viewModel.createFamily()
                completion()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct SelectFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFamilyView() { }
    }
}
