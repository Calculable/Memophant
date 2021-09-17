import Foundation
import UIKit

@IBDesignable
final class MemoEntryView: UIView {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentTextLabel: UITextView!
    
    var memo: Memo? = nil
    var viewControllerDelegate: ViewController? = nil
    
    
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
    
    func configureView(memo: Memo, viewControllerDelegate: ViewController) {
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        // get the date time String from the date object
        
        let timeString = formatter.string(from: memo.date!) // October 8, 2016 at 10:48:53 PM
        print(timeString)
        
        timeLabel.text = timeString
        contentTextLabel.text = memo.content!
        
        self.memo = memo
        self.viewControllerDelegate = viewControllerDelegate
    }
    
    
    @IBAction func edit(_ sender: Any) {
        viewControllerDelegate?.editMemo(memo: memo!)
    }
    
}
