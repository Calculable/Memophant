//
//  CalendarService.swift
//  Memophant
//
//  Created by Jan on 17.09.21.
//

import Foundation

class CalendarService {
    static func monthName(monthNumber: Int) -> String {
        return DateFormatter().monthSymbols[monthNumber - 1]
    }
}
