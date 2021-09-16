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
    @IBOutlet weak var time: UILabel!
    
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
        time?.layer.masksToBounds = true
        time?.layer.cornerRadius = 8.0
    }
    
    func configureView(text: String) {
        label.text = text
    }
    
    
    
}
