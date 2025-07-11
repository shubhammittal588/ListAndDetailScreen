//
//  ServiceDetailView.swift
//  ListAndDetailScreen
//
//  Created by Shubham Mittal on 11/07/25.
//

import SwiftUI
import MapKit

@available(iOS 16.0, *)
struct ServiceDetailView: View {
    let service: Service
    @State private var region: MKCoordinateRegion
    
    init(service: Service) {
        self.service = service
        _region = State(initialValue: MKCoordinateRegion(
            center: service.location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Map View
                Map(coordinateRegion: $region, annotationItems: [service]) { service in
                    MapMarker(coordinate: service.location)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(spacing: 24) {
                    // Customer Information
                    HStack {
                        Text(service.title)
                            .font(.title2)
                            .bold()
                            
                        Spacer()
                        StatusBadgeView(status: service.status)
                    }
                    InfoSection(title: "Customer", icon: "person.circle") {
                        Text(service.customerName)
                            .padding(.leading, 25)
                    }
                    
                    // Description
                    InfoSection(title: "Description", icon: "doc.text") {
                        Text(service.description)
                            .padding(.leading, 25)
                    }
                    
                    // Scheduled Time
                    InfoSection(title: "Scheduled Time", icon: "clock") {
                        Text(service.scheduledTime.smartFormat())
                            .padding(.leading, 25)
                    }
                    
                    // Location
                    InfoSection(title: "Location", icon: "mappin.circle") {
                        Text(service.address)
                            .padding(.leading, 25)
                        
                    }
                    
                    // Service Notes
                    InfoSection(title: "Service Notes", icon: "note.text") {
                        Text(service.serviceNotes)
                            .padding(.leading, 25)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    let content: () -> Content
    
    init(title: String, icon: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.accentColor)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .bold()
            }
            
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
} 
