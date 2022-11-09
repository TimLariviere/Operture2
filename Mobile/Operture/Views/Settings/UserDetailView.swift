//
//  UserView.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.dismiss) var dismissAction: DismissAction
    @State private var editMode = EditMode.inactive
    @StateObject private var viewModel: UserDetailViewModel
    
    init(_ id: UUID) {
        _viewModel = StateObject(wrappedValue: UserDetailViewModel(id))
    }
    
    var body: some View {
        List {
            if editMode.isEditing == true {
                editBody
            }
            else {
                readonlyBody
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
    
    var readonlyBody: some View {
        Group {
            picture
            details
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
                Text("Email")
                Spacer()
                Text(viewModel.email)
            }
        }
    }
    
    var editableDetails: some View {
        Section {
            HStack {
                Text("Name")
                TextField("Name", text: $viewModel.name)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Email")
                Spacer()
                Text(viewModel.email)
                    .foregroundColor(.gray)
            }
        }
    }
    
    var destructiveActions: some View {
        if viewModel.isCurrentUser {
            return
                Section {
                    Button("Delete account", role: .destructive) {
                        viewModel.delete {
                            dismissAction()
                        }
                    }
                }
        }
        else {
            return
                Section {
                    Button("Remove from household", role: .destructive) {
                        
                    }
                }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(UUID())
    }
}
