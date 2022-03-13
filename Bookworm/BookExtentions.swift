//
//  BookExtentions.swift
//  Bookworm
//
//  Created by Raymond Chen on 3/12/22.
//

import Foundation

extension Book {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        var dateString = "Unknown Date"
        if let date = self.date {
            dateString = formatter.string(from: date)
        }
        
        return dateString
    }
}
