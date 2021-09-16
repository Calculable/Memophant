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
               
        
        dayStackView.backgroundColor = .red

        for day in 1...30 {
        
            let dayView = DayView()
            dayView.configureView(text: "\(day)")
            dayStackView.addArrangedSubview(dayView)

        }
        
        
       

    }
    
    


}

