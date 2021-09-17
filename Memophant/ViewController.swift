//
//  ViewController.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var dayStackView: UIStackView!
    
    var memosPerMonth: [MonthAndYear: [Memo]] = [:]
    var orderedMemoDictionaryKeys : [MonthAndYear] = []
    var currentMemoDictionaryKeyIndex = 0
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goToNewestButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memos = loadDummyMemos()
        
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
           
        
        
        
       updateView()
    
        
        
       

    }
    
    func updateButtonEnabledState() {
        backButton.isEnabled = currentMemoDictionaryKeyIndex < orderedMemoDictionaryKeys.count - 1
        forwardButton.isEnabled = currentMemoDictionaryKeyIndex > 0
        goToNewestButton.isEnabled = currentMemoDictionaryKeyIndex != 0

    }
    
    func updateView() {
        
        updateButtonEnabledState()
        
        dayStackView.removeAllArrangedSubviews()
        
        
        let memosForSelectedMonthKey = orderedMemoDictionaryKeys[currentMemoDictionaryKeyIndex]
        let memosForSelectedMonth = memosPerMonth[memosForSelectedMonthKey]
        
        //check which entrys should be grouped together
        
        var currentGroupedEntrys: [Memo] =  []
        var currentDay: Int? = nil
        
        
        memosForSelectedMonth!.forEach {memo in
            
            if (currentDay == nil) {
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
            } else if (currentDay == getDayFromMemo(memo: memo)) {
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
            } else {
                
                //Gruppe hinzufügen
                let dayView = DayView()
                dayView.configureView(day: "\(currentDay!)", memos: currentGroupedEntrys)
                dayStackView.addArrangedSubview(dayView)
                
                currentGroupedEntrys.removeAll()
                
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
                
                
            }
            
            
        }
        
        //Gruppe hinzufügen
        let dayView = DayView()
        dayView.configureView(day: "\(currentDay!)", memos: currentGroupedEntrys)
        dayStackView.addArrangedSubview(dayView)
        
        
        
        
    }
    
    func loadDummyMemos() -> [Memo] {
        MemoRepository.shared.deleteAllMemos()
        
        let memos0 = MemoRepository.shared.allMemos
        
        
        memos0.forEach { memo in
            print(memo.content)
            
        }
        
        
        MemoRepository.shared.readDummyMemos().forEach { memo in
            MemoRepository.shared.updateMemo(memo: memo)
        }
               
        
        let memos = MemoRepository.shared.allMemos
        return memos
    }
    
    func splitMemosPerMonth(memos: [Memo]) -> [MonthAndYear: [Memo]]{
        
        var memosPerMonth: [MonthAndYear: [Memo]] = [:]
        
        memos.forEach { memo in
            let monthAndYear = MonthAndYear(month: getMonthFromMemo(memo: memo), year: getYearFromMemo(memo: memo))
            
            if (memosPerMonth[monthAndYear] == nil) {
                memosPerMonth[monthAndYear] = [memo]
            } else {
                memosPerMonth[monthAndYear]!.append(memo)
            }
            
        }
        
        return memosPerMonth
        
    }
    
  
    func getYearFromMemo(memo: Memo) -> Int {
        return memo.date!.get(.year).year!
    }
    
    func getMonthFromMemo(memo: Memo) -> Int{
        return memo.date!.get(.month).month!
    }
    
    func getDayFromMemo(memo: Memo) -> Int {
        return memo.date!.get(.day).day!
    }
    
    
    @IBAction func back(_ sender: Any) {
        currentMemoDictionaryKeyIndex += 1
        updateView()
    }
    
    @IBAction func newest(_ sender: Any) {
        currentMemoDictionaryKeyIndex = 0
        updateView()
    }
    
    @IBAction func forward(_ sender: Any) {
        currentMemoDictionaryKeyIndex -= 1
            updateView()
    }
    
}

