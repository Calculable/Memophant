//
//  DayView.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import UIKit

@IBDesignable
final class DayView: UIView {
    
        
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var memoEntryStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "DayView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        
    }
    
    
    func configureDummyView(day: String) {
        label.text = day
        
        let entry1 = MemoEntryView()
        entry1.configureView(time: "9:41", content: "Test1")
        
        let entry2 = MemoEntryView()
        entry1.configureView(time: "8:41", content: "Test2")
        
        memoEntryStackView.addArrangedSubview(entry1)
        memoEntryStackView.addArrangedSubview(entry2)
    }
    
    
    func configureView(day: String, memos: [Memo]) {
        label.text = day
        
        
        memos.forEach { memo in
            let entry = MemoEntryView()
            
            // get the current date and time
            let currentDateTime = Date()

            // initialize the date formatter and set the style
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none

            // get the date time String from the date object
            
            let timeString = formatter.string(from: memo.date!) // October 8, 2016 at 10:48:53 PM
            print(timeString)
            
            entry.configureView(time: timeString, content: memo.content ?? "")
            memoEntryStackView.addArrangedSubview(entry)
        }
       
    }
    
    
    
}
