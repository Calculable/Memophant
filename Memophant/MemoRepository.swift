//
//  MemoRepository.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import Foundation

class MemoRepository {
    
    static func readMemos() -> [Memo] {
    
        
        let memo1: Memo = {
            let memo = Memo()
            memo.content = "The people who are crazy enough to think they can change the world are the ones who do."
            memo.date = Date()
            return memo
        }()
        
        let memo2: Memo = {
            let memo = Memo()
            memo.content = "I’m as proud of many of the things we haven’t done as the things we have done. Innovation is saying no to a thousand things."
            memo.date = Date(timeIntervalSinceNow: -300)
            return memo
        }()
        
        let memo3: Memo = {
            let memo = Memo()
            memo.content = "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle. As with all matters of the heart, you’ll know when you find it."
            memo.date = Date(timeIntervalSinceNow: -600)
            return memo
        }()
        
        
        return [memo1, memo2, memo3]
       
        
    }
    
}
