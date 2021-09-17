//
//  MemoOrganizer.swift
//  Memophant
//
//  Created by Jan on 17.09.21.
//

import Foundation

class MemoViewModel {
    
    //MARK: Properties
    var memosPerMonth: [MonthAndYear: [Memo]] = [:]
    var orderedMemoDictionaryKeys : [MonthAndYear] = []
    var currentMemoDictionaryKeyIndex = 0
    
    func setMemos(memos: [Memo], shouldJumpToFirstDay: Bool) {
        memosPerMonth = splitMemosPerMonth(memos: memos)
        
        orderedMemoDictionaryKeys = memosPerMonth.keys.sorted { (a,b) in
            
            if a.year > b.year {
                return true
            }
            
            if (a.year == b.year) {
                return a.month > b.month
            }
            
            return false
            
        }
        
        if (shouldJumpToFirstDay || currentMemoDictionaryKeyIndex >= orderedMemoDictionaryKeys.count) {
            currentMemoDictionaryKeyIndex = 0
        }
    }
    
    private func splitMemosPerMonth(memos: [Memo]) -> [MonthAndYear: [Memo]]{
        var memosPerMonth: [MonthAndYear: [Memo]] = [:]
        memos.forEach { memo in
            let monthAndYear = MonthAndYear(month: memo.month, year: memo.year)
            if (memosPerMonth[monthAndYear] == nil) {
                memosPerMonth[monthAndYear] = [memo]
            } else {
                memosPerMonth[monthAndYear]!.append(memo)
            }
        }
        return memosPerMonth
    }

}
