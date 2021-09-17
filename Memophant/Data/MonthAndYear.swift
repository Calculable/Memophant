//
//  DayAndYear.swift
//  Memophant
//
//  Created by Jan on 17.09.21.
//

import Foundation

struct MonthAndYear: Hashable {
    
    let month: Int;
    let year: Int;
    
    init(month: Int, year: Int) {
        self.month = month
        self.year = year
    }
    
}
