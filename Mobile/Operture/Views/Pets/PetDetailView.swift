//
//  PetView.swift
//  Operture
//
//  Created by Timothé Larivière on 27/10/2022.
//

import SwiftUI

struct PetDetailView: View {
    @State private var editMode = EditMode.inactive
    @StateObject private var viewModel: PetDetailViewModel
    
    init(id: UUID) {
        _viewModel = StateObject(wrappedValue: PetDetailViewModel(id))
    }
    
    var body: some View {
        List {
            if editMode.isEditing {
                editBody
            }
            else {
                readOnlyBody
            }
        }
        .navigationTitle(viewModel.name)
        .toolbar {
            if self.editMode.isEditing {
                Button("Done") {
                    self.editMode = .inactive
                }
            }
            else {
                Button("Edit") {
                    self.editMode = .active
                }
            }
        }
        .environment(\.editMode, $editMode)
        .onChange(of: editMode) { value in
            if value.isEditing == false {
                viewModel.save()
            }
        }
    }
    
    var readOnlyBody: some View {
        Group {
            picture
            details
            health
            food
            destructiveActions
        }
    }
    
    var editBody: some View {
        Group {
            editablePicture
            editableDetails
        }
    }
    
    var picture: some View {
        Section {
            AvatarImage(viewModel.picture, initials: viewModel.initials)
                .frame(width: 160, height: 160)
                .frame(maxWidth: .infinity)
        }
        .listRowBackground(Color.clear)
    }
    
    var editablePicture: some View {
        Section {
            ZStack {
                AvatarImage(viewModel.picture, initials: viewModel.initials)
                
                Button {
                    
                } label: {
                    Image(systemName: "camera")
                        .frame(width: 60, height: 60)
                        .background(Material.thin, in: Circle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            .frame(width: 160, height: 160)
            .frame(maxWidth: .infinity)
        }
        .listRowBackground(Color.clear)
    }
    
    var details: some View {
        Section {
            HStack {
                Text("Name")
                Spacer()
                Text(viewModel.name)
            }
            HStack {
                Text("Birthdate")
                Spacer()
                Text(viewModel.birthdate, style: .date)
            }
            HStack {
                Text("Type")
                Spacer()
                Text(viewModel.type.localizedKey)
            }
            HStack {
                Text("Sex")
                Spacer()
                Text(viewModel.sex.localizedKey)
            }
            if let race = viewModel.race {
                HStack {
                    Text("Race")
                    Spacer()
                    Text(race)
                }
            }
            if let colors = viewModel.colors {
                HStack {
                    Text("Colors")
                    Spacer()
                    Text(colors)
                }
            }
        }
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
    
    var health: some View {
        Section("Health") {
            NavigationLink(value: true) {
                HStack {
                    Text("Weight")
                    Spacer()
                    
                    if let currentWeight = viewModel.currentWeight {
                        VStack(spacing: 4) {
                            Text("\(currentWeight.value, specifier: "%.1f") kg")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text(currentWeight.date, style: .date)
                                .font(.caption2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    else {
                        Text("No data")
                    }
                }
            }
            NavigationLink(value: true) {
                HStack {
                    Text("Veterinary")
                    Spacer()
                    
                    if let nextVisit = viewModel.nextVeterinaryVisit {
                        VStack(spacing: 4) {
                            Text(nextVisit.type.localizedKey)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text(nextVisit.date, style: .date)
                                .font(.caption2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    else {
                        Text("No visit planned")
                    }
                }
            }
            NavigationLink(value: true) {
                Text("Vaccines")
            }
        }
    }
    
    var food: some View {
        Section("Food") {
            NavigationLink(value: true) {
                Text("Eating schedule")
            }
        }
    }
    
    var destructiveActions: some View {
        Section {
            Button("Delete pet", role: .destructive) {
                
            }
        }
    }
}

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailView(id: UUID())
    }
}
