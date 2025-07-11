//
//  ServiceListViewModel.swift
//  ListAndDetailScreen
//
//  Created by Shubham Mittal on 11/07/25.
//

import SwiftUI

@available(iOS 16.0, *)

struct ServiceListView: View {
    @StateObject private var viewModel = ServiceViewModel()
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.filteredServices) { service in
                        ZStack {
                            ServiceRowView(service: service)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .background(Color.clear)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.refreshServices()
                }
                
                .searchable(text: $viewModel.searchText, prompt: "Search services...")
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    isKeyboardVisible = false
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    isKeyboardVisible = true
                }

                .overlay(alignment: .top) {
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .named("scroll")).minY

                        if viewModel.searchText.isEmpty && !isKeyboardVisible {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.gray)// moves it to the right edge
                                .padding(.leading , 350)
                                .padding(.top, max(-40 + minY, -40)) // moves it down on pull
                                .animation(.easeInOut(duration: 0.05), value: minY)
                                .allowsHitTesting(false)
                        }
                    }
                    .frame(height: 0)
                }

                    if viewModel.isLoading {
                        ProgressView()
                            .scaleEffect(1.5)
                    }
                
            }
            .navigationTitle("Services")
            .coordinateSpace(name: "scroll") 
        }
    }
}

struct ServiceRowView: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(service.title)
                    .font(.headline)
                Spacer()
                PriorityIndicator(level: service.priorityLevel)
                
            }
            
            HStack {
                Image(systemName: "person.circle")
                    .foregroundColor(.blue)
                Text(service.customerName)
                    .foregroundColor(.black)
            }
            .font(.subheadline)
            
            HStack {
                Image(systemName: "doc.text")
                    .foregroundColor(.blue)
                    .padding(.top, -15)
                Text(service.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
            .font(.subheadline)
            
            HStack {
                StatusBadgeView(status: service.status)
                
                Spacer()
                
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                Text(service.scheduledTime.smartFormat())
                    .foregroundColor(.black)
            }
            .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .padding(.vertical, 4)
    }
}

struct StatusBadgeView: View {
    let status: ServiceStatus

    var body: some View {
        HStack(spacing: 6) {
            Rectangle()
                .fill(status.color)
                .frame(width: 10, height: 10)
                .cornerRadius(2)

            Text(status.rawValue)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(status.color.opacity(0.2))
        .foregroundColor(status.color)
        .clipShape(Capsule())
    }

}

struct PriorityIndicator: View {
    let level: Int
    
    var body: some View {
        HStack(spacing: 2) {
            Circle()
                .fill(color(for: level))
                .frame(width: 8, height: 8)
        }
    }
    
    private func color(for level: Int) -> Color {
        switch level {
        case 3: return .red
        case 2: return .yellow
        case 1: return .green
        default: return .gray
        }
    }
}
