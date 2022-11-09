//
//  EventDetailView.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import SwiftUI

struct EventDetailView: View {
    @State private var editMode = EditMode.inactive
    @StateObject private var viewModel: EventDetailViewModel
    
    init(id: UUID) {
        _viewModel = StateObject(wrappedValue: EventDetailViewModel(id))
    }
    
    var body: some View {
        List {
            if editMode.isEditing {
                editBody
            }
            else {
                readonlyBody
            }
        }
        .navigationTitle(viewModel.type.localizedKey)
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
    
    var readonlyBody: some View {
        Group {
            details
            
            if viewModel.pets.count > 0 {
                pets
            }
            
            if viewModel.people.count > 0 {
                people
            }
        }
    }
    
    var editBody: some View {
        Group {
            editableDetails
            editablePets
            editablePeople
        }
    }
    
    var details: some View {
        Section {
            HStack {
                Text("Type")
                Spacer()
                Text(viewModel.type.localizedKey)
            }
            HStack {
                Text("Date")
                Spacer()
                Text(viewModel.dateTime, style: .date)
            }
            HStack {
                Text("Time")
                Spacer()
                Text(viewModel.dateTime, style: .time)
            }
        }
    }
    
    var editableDetails: some View {
        Section {
            Picker("Type", selection: $viewModel.type) {
                ForEach(EventType.allCases, id: \.self) { type in
                    Text(type.localizedKey)
                }
            }
            DatePicker("Date", selection: $viewModel.dateTime, displayedComponents: [.date])
            DatePicker("Time", selection: $viewModel.dateTime, displayedComponents: [.hourAndMinute])
        }
    }
    
    var pets: some View {
        Section("Pets") {
            ForEach(viewModel.pets) { pet in
                HStack(spacing: 20) {
                    AvatarImage(pet.picture, initials: pet.initials)
                        .frame(width: 60, height: 60)
                    
                    Text(pet.name)
                }
            }
        }
    }
    
    var editablePets: some View {
        Section("Pets") {
            ForEach(viewModel.pets) { pet in
                HStack(spacing: 20) {
                    AvatarImage(pet.picture, initials: pet.initials)
                        .frame(width: 60, height: 60)
                    
                    Text(pet.name)
                }
            }.onDelete { index in
                viewModel.pets.remove(atOffsets: index)
            }
            
            Button {
                
            } label: {
                Label("Add pet", systemImage: "plus.circle")
            }
        }
    }
    
    var people: some View {
        Section("People") {
            ForEach(viewModel.people) { person in
                HStack(spacing: 20) {
                    AvatarImage(person.picture, initials: person.initials)
                        .frame(width: 60, height: 60)
                    
                    Text(person.name)
                }
            }
        }
    }
    
    var editablePeople: some View {
        Section("People") {
            ForEach(viewModel.people) { person in
                HStack(spacing: 20) {
                    AvatarImage(person.picture, initials: person.initials)
                        .frame(width: 60, height: 60)
                    
                    Text(person.name)
                }
            }.onDelete { index in
                viewModel.people.remove(atOffsets: index)
            }
            
            Button {
                
            } label: {
                Label("Add family member", systemImage: "plus.circle")
            }
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(id: UUID())
    }
}
