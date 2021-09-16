//
//  MemoryEntryView.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import Foundation
import UIKit

@IBDesignable
final class MemoEntryView: UIView {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentTextLabel: UITextView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "MemoEntryView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        timeLabel?.layer.masksToBounds = true
        timeLabel?.layer.cornerRadius = 8.0

      
    }
    
    func configureView(time: String, content: String) {
        timeLabel.text = time
        contentTextLabel.text = content
    }
    
    
    
}
