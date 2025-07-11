//
//  ServiceListViewModel.swift
//  ListAndDetailScreen
//
//  Created by Shubham Mittal on 11/07/25.
//

import Foundation
import CoreLocation
import SwiftUI

enum ServiceStatus: String, CaseIterable {
    case planned = "Planned"
    case scheduled = "Scheduled"
    case confirmed = "Confirmed"
    case approved = "Approved"
    
    var color: Color {
        switch self {
        case .planned: return .blue
        case .scheduled: return .green
        case .confirmed: return .indigo
        case .approved: return .orange
        }
    }
}

struct Service: Identifiable {
    let id: UUID
    let title: String
    let customerName: String
    let description: String
    let status: ServiceStatus
    let scheduledTime: Date
    let location: CLLocationCoordinate2D
    let address: String
    let serviceNotes: String
    let priorityLevel: Int
    
    var priorityColor: Color {
        switch priorityLevel {
        case 3: return .red
        case 2: return .yellow
        case 1: return .green
        default: return .gray
        }
    }
}

extension Service {
    static var mockData: [Service] = [
        Service(
            id: UUID(),
            title: "Office Space Revamp",
            customerName: "XYZ Industries",
            description: "Transform your office with sleek, contemporary furnishings.",
            status: .planned,
            scheduledTime: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date()) ?? Date(),
            location: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321),
            address: "Maple Avenue, Seattle, WA 98101",
            serviceNotes: "Ensure all furniture is removed before the renovation begins. Confirm the layout with the client and finalize color schemes for walls and furnishings.",
            priorityLevel: 3
        ),
        Service(
            id: UUID(),
            title: "Modern Workspace Makeover",
            customerName: "Acme Corp",
            description: "Revitalize your workspace with stylish, modern decor that inspires creativity.",
            status: .scheduled,
            scheduledTime: Calendar.current.date(bySettingHour: 15, minute: 30, second: 0, of: Date()) ?? Date(),
            location: CLLocationCoordinate2D(latitude: 47.6092, longitude: -122.3151),
            address: "Pine Street, Seattle, WA 98101",
            serviceNotes: "Client prefers minimalist design. Focus on ergonomic furniture and natural lighting solutions.",
            priorityLevel: 2
        ),
        Service(
            id: UUID(),
            title: "Contemporary Office Transformation",
            customerName: "Beta Solutions",
            description: "Elevate your office environment with chic, innovative designs that spark inspiration.",
            status: .confirmed,
            scheduledTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date()) ?? Date(),
            location: CLLocationCoordinate2D(latitude: 47.6132, longitude: -122.3391),
            address: "1st Avenue, Seattle, WA 98101",
            serviceNotes: "Incorporate smart office solutions. Set up IoT devices and ensure proper connectivity.",
            priorityLevel: 2
        ),
        Service(
            id: UUID(),
            title: "Modern Workspace Overhaul",
            customerName: "Alpha Innovations",
            description: "Transform your workspace with stylish, cutting-edge designs that inspire creativity.",
            status: .approved,
            scheduledTime: Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date()) ?? Date(),
            location: CLLocationCoordinate2D(latitude: 47.6172, longitude: -122.3241),
            address: "Bell Street, Seattle, WA 98101",
            serviceNotes: "Focus on collaborative spaces. Install modular furniture for flexibility.",
            priorityLevel: 1
        ),
        Service(
            id: UUID(),
            title: "Revamp Your Workspace Today",
            customerName: "Innovative Solutions Inc.",
            description: "Create an inspiring workspace that boosts productivity and employee satisfaction.",
            status: .planned,
            scheduledTime: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(),
            location: CLLocationCoordinate2D(latitude: 47.6152, longitude: -122.3361),
            address: "Western Avenue, Seattle, WA 98101",
            serviceNotes: "Emphasize sustainable materials and green design principles.",
            priorityLevel: 3
        )
    ]
} 
