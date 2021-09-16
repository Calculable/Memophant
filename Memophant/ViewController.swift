//
//  ViewController.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dayStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoRepository.shared.deleteAllMemos()
        
        let memos0 = MemoRepository.shared.allMemos
        
        
        memos0.forEach { memo in
            print(memo.content)
            
        }
        
        
        MemoRepository.shared.readDummyMemos().forEach { memo in
            MemoRepository.shared.updateMemo(memo: memo)
        }
               
        
        let memos = MemoRepository.shared.allMemos
        
        
        memos.forEach { memo in
            print(memo.content)
            
        }
        
        let dayView = DayView()
        dayView.configureView(day: "1", memos: memos)
        dayStackView.addArrangedSubview(dayView)
        
        for day in 2...30 {
        
            let dayView = DayView()
            dayView.configureDummyView(day: "\(day)")
            dayStackView.addArrangedSubview(dayView)

        }
        
        
       

    }
    
    


}

