//
//  Date+extension.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import Foundation

extension Date {
    func formattedDayMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
