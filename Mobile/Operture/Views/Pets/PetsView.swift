//
//  PetsView.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import SwiftUI

struct PetsView: View {
    @State private var showAddPetView = false
    @StateObject private var viewModel = PetsViewModel()
    
    var ageFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            List {
                pets
            }
            .navigationTitle("Pets")
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                
                ToolbarItem {
                    Button {
                        showAddPetView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: UUID.self) { id in
                PetDetailView(id: id)
            }
            .sheet(isPresented: $showAddPetView) {
                AddPetView()
            }
            .onAppear {
                viewModel.load()
            }
        }
    }
    
    var pets: some View {
        Section {
            ForEach(viewModel.pets) { pet in
                NavigationLink(value: pet.id) {
                    HStack(spacing: 16) {
                        AvatarImage(pet.picture, initials: pet.initials)
                            .frame(width: 60, height: 60)
                        
                        VStack(spacing: 4) {
                            Text(pet.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("4.5 kg - \(pet.age.clean) years old")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

struct PetsView_Previews: PreviewProvider {
    static var previews: some View {
        PetsView()
    }
}
