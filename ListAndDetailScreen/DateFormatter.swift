//
//  ServiceListViewModel.swift
//  ListAndDetailScreen
//
//  Created by Shubham Mittal on 11/07/25.
//

import Foundation

extension Date {
    func smartFormat() -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "Today, " + formatter.string(from: self)
        }
        
        if calendar.isDateInTomorrow(self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "Tomorrow, " + formatter.string(from: self)
        }
        
        if calendar.isDateInYesterday(self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "Yesterday, " + formatter.string(from: self)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, h:mm a"
        return formatter.string(from: self)
    }
} 
