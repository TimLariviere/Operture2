//
//  AddPetView.swift
//  Operture
//
//  Created by Timothé Larivière on 27/10/2022.
//

import SwiftUI

struct AddPetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @StateObject var viewModel = AddPetViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                editablePicture
                editableDetails
            }
            .navigationTitle("Add pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }
    
    var editablePicture: some View {
        Section {
            ZStack {
                if let picture = image {
                    picture
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                }
                else {
                    ZStack {
                        Color.accentColor
                        Text(viewModel.initials.uppercased())
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .clipShape(Circle())
                }
                
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "camera")
                        .frame(width: 60, height: 60)
                        .background(Material.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            .frame(width: 160, height: 160)
            .frame(maxWidth: .infinity)
        }
        .listRowBackground(Color.clear)
    }
    
    var editableDetails: some View {
        Section {
            HStack {
                Text("Name")
                Spacer()
                TextField("Name", text: $viewModel.name)
                    .multilineTextAlignment(.trailing)
            }
            
            DatePicker("Birthdate", selection: $viewModel.birthdate, displayedComponents: .date)
            
            Picker("Type", selection: $viewModel.type) {
                ForEach(PetType.allCases, id: \.self) { type in
                    Text(type.localizedKey)
                }
            }
            
            Picker("Sex", selection: $viewModel.sex) {
                ForEach(PetSex.allCases, id: \.self) { sex in
                    Text(sex.localizedKey)
                }
            }
            
            HStack {
                Text("Race")
                Spacer()
                TextField("Race", text: $viewModel.race.bound)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Colors")
                Spacer()
                TextField("Colors", text: $viewModel.colors.bound)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage)
    }
}

struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView()
    }
}
