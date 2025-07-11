# ListAndDetailScreen

# ListAndDetail

A modern iOS application that demonstrates a master-detail view pattern for managing and displaying services. The app showcases various SwiftUI features and follows MVVM architecture.

https://github.com/user-attachments/assets/e6b255dc-19c2-4648-a79c-5790184e843b



## Features

- 📱 Master-detail interface with a list of services and detailed views
- 🔍 Real-time search functionality
- ↻ Pull-to-refresh for updating service data
- 📊 Status indicators with color-coded badges
- ⭐ Priority level visualization
- 🎨 Clean and modern SwiftUI interface
- 📱 iOS 16.0+ support

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture:

- **Models**: Contains the data models like `Service`
- **Views**: Contains SwiftUI views for displaying the UI
- **ViewModels**: Contains the business logic and data management

## Key Components

- `ServiceListView`: Main list view displaying all services with search and refresh capabilities
- `ServiceDetailView`: Detailed view for individual services
- `ServiceViewModel`: Manages the business logic and data operations
- `DateFormatter`: Custom date formatting utilities

## Installation

1. Clone the repository:
```bash
git clone https://github.com/shubhammittal588/ListAndDetailScreen.git
```

2. Open `ListAndDetail.xcodeproj` in Xcode

3. Build and run the project (⌘+R)
