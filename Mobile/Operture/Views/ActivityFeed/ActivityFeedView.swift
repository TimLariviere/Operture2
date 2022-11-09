//
//  ActivityFeedView.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import SwiftUI

struct ActivityFeedView: View {
    @StateObject private var viewModel = ActivityFeedViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                callout
                events
            }
            .navigationTitle("Activity feed")
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: EventModel.self) { event in
                EventDetailView(id: event.id)
            }
            .onAppear {
                viewModel.load()
            }
        }
    }
    
    var callout: some View {
        Section("Coming up soon") {
            eventCell()
            eventCell()
        }
    }
    
    var events: some View {
        ForEach(Array(viewModel.events.keys), id: \.self) { date in
            Section(date.formatted(date: .long, time: .omitted)) {
                ForEach(viewModel.events[date]!) { event in
                    eventCell2(event)
                }
            }
        }
    }
    
    func eventCell2(_ event: EventModel) -> some View {
        NavigationLink(value: event) {
            HStack {
                VStack {
                    HStack {
                        Image(systemName: symbolForEventType(event.type))
                        
                        VStack {
                            Text(event.type.localizedKey)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(event.pets.joined(separator: ", "))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    if event.notes != "" {
                        Text(event.notes)
                    }
                }
                
                Spacer()
                
                Text(event.dateTime.formatted(date: .omitted, time: .shortened))
            }
        }
    }
    
    func symbolForEventType(_ eventType: EventType) -> String {
        switch eventType {
        case .appointment:
            return "cross"
        }
    }
    
    func eventCell() -> some View {
        Text("Hello")
    }
}

struct ActivityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFeedView()
    }
}
