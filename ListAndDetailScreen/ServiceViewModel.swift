//
//  ServiceListViewModel.swift
//  ListAndDetailScreen
//
//  Created by Shubham Mittal on 11/07/25.
//

import Foundation
import Combine

@MainActor
class ServiceViewModel: ObservableObject {
    @Published var services: [Service] = []
    @Published var searchText: String = ""
    @Published var filteredServices: [Service] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSearchSubscription()
        loadServices()
    }
    
    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterServices(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterServices(searchText: String) {
        if searchText.isEmpty {
            filteredServices = services
            return
        }
        
        filteredServices = services.filter { service in
            service.title.localizedCaseInsensitiveContains(searchText) ||
            service.customerName.localizedCaseInsensitiveContains(searchText) ||
            service.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func loadServices() {
        // Simulating network delay
        isLoading = true
        
        Task {
            try? await Task.sleep(for: .seconds(2))
            services = Service.mockData
            filteredServices = services
            isLoading = false
        }
    }
    
    func refreshServices() async {
        isLoading = true
        // Simulating network delay
        try? await Task.sleep(for: .seconds(2))
        services = Service.mockData.shuffled() // refresh data
        filteredServices = services
        isLoading = false
    }
} 
