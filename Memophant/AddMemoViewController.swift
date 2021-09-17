//
//  AddMemoViewController.swift
//  Memophant
//
//  Created by Jan on 16.09.21.
//

import Foundation
import UIKit

class AddMemoViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var viewControllerDelegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.becomeFirstResponder()
        
    }
    
   
    @IBAction func saveMemo(_ sender: Any) {
        let content = contentTextView.text
        
        if (content != nil && !content!.isEmpty) {
            MemoRepository.shared.addMemo(content: content!)
            
            print(presentationController!)
            
            viewControllerDelegate?.updateView(shouldRefreshMemos: true)
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    


}


