import Foundation
import UIKit

class AddMemoViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var deleteOrDiscardMemoButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Properties
    var currentEditingMemo: Memo? = nil
    var editingMode = false
    var viewControllerDelegate: AddMemoViewDelegate?
    
    //MARK: User-Interface Texts
    struct UIText { //ToDo: Translate
        static let deleteAlertTitle = "Delete memo"
        static let deleteAlertMessage = "Do you want to delete the memo?"
        static let no = "No"
        static let delete = "Delete"
        static let yes = "Yes"
        static let cancel = "Cancel"
        static let discardMessage = "Do you want to discard the memo?"
        static let editMemo = "Edit Memo"
        static let addMemo = "Add Memo"
    }
    
    //MARK: Superclass Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.becomeFirstResponder()
        updateViewForCreateOrEdit()
    }
    
    //MARK: Actions
    @IBAction func saveMemo(_ sender: Any) {
        let content = contentTextView.text
        
        if (content != nil && !content!.isEmpty) {
            if (editingMode) {
                currentEditingMemo!.content = content
                MemoRepository.shared.updateMemos()
            } else {
                MemoRepository.shared.createMemo(date: Date(), content: content!)
            }
        }
        
        viewControllerDelegate?.updateView(shouldJumpToFirstDay: !editingMode)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func discardOrDelete(_ sender: Any) {
        if (editingMode) {
           deleteMemo()
        } else {
            discardMemo()
        }
    }
    
    //MARK: View Methods
    func deleteMemo() {
        //Ask if memo should be deleted
        let alert = UIAlertController(title: UIText.deleteAlertTitle, message: UIText.deleteAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UIText.no, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: UIText.delete, style: .destructive) { _ in
            MemoRepository.shared.deleteMemo(memo: self.currentEditingMemo!)
            self.viewControllerDelegate?.updateView(shouldJumpToFirstDay: false)
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true)
    }
    
    func discardMemo() {
        if (contentTextView.text.isEmpty) {
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: UIText.cancel, message: UIText.discardMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: UIText.no, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: UIText.yes, style: .destructive) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            self.present(alert, animated: true)
        }
    }
    
    func updateViewForCreateOrEdit() {
        if (editingMode) {
            titleLabel.text = UIText.editMemo
            deleteOrDiscardMemoButton.setTitle(UIText.delete, for: .normal)
            deleteOrDiscardMemoButton.setTitleColor(.red, for: .normal)
            contentTextView.text = currentEditingMemo!.content
            
        } else {
            titleLabel.text = UIText.addMemo
            deleteOrDiscardMemoButton.setTitle(UIText.cancel, for: .normal)
            deleteOrDiscardMemoButton.setTitleColor(.systemPurple, for: .normal)
        }
    }

}


