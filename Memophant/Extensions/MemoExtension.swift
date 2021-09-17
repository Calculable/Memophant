//
//  MemoExtension.swift
//  Memophant
//
//  Created by Jan on 17.09.21.
//

import Foundation

extension Memo {
   
    var year: Int {
        return self.date!.get(.year).year!
    }
    
    var month: Int {
        return self.date!.get(.month).month!
    }
    
    var day: Int {
        return self.date!.get(.day).day!
    }
    
}
