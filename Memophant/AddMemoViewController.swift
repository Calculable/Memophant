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
    
    @IBOutlet weak var deleteOrDiscardMemoButton: UIButton!

    
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentEditingMemo: Memo? = nil
    var editingMode = false
    
    func updateViewForCreateOrEdit() {
        if (editingMode) {
            titleLabel.text = "Edit Memo"
            deleteOrDiscardMemoButton.setTitle("Delete", for: .normal)
            deleteOrDiscardMemoButton.setTitleColor(.red, for: .normal)
            contentTextView.text = currentEditingMemo!.content
            
        } else {
            titleLabel.text = "Add Memo"
            deleteOrDiscardMemoButton.setTitle("Discard", for: .normal)
            deleteOrDiscardMemoButton.setTitleColor(.systemPurple, for: .normal)
        }
    }
    
    
    var viewControllerDelegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.becomeFirstResponder()
        updateViewForCreateOrEdit()
        
    }
    
   
    @IBAction func saveMemo(_ sender: Any) {
        let content = contentTextView.text
        
        if (content != nil && !content!.isEmpty) {
            
            if (editingMode) {
                currentEditingMemo!.content = content
                MemoRepository.shared.updateMemo(memo: currentEditingMemo!)
            } else {
                MemoRepository.shared.addMemo(content: content!)
            }
        }
        
        viewControllerDelegate?.updateView(shouldRefreshMemos: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func discardOrDelete(_ sender: Any) {
        if (editingMode) {
            
            //Ask if memo should be deleted
            
            let alert = UIAlertController(title: "Delete memo", message: "Do you want to delete the memo?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                print("Should delete")
                MemoRepository.shared.deleteMemo(memo: self.currentEditingMemo!)
                self.viewControllerDelegate?.updateView(shouldRefreshMemos: true)
                self.dismiss(animated: true, completion: nil)
            })
            
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))


            self.present(alert, animated: true)
            
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    

}


