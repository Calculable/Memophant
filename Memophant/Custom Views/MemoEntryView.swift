import Foundation
import UIKit

@IBDesignable
final class MemoEntryView: UIView {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentTextLabel: UITextView!
    
    var memo: Memo? = nil
    var viewControllerDelegate: MemoEntryViewDelegate? = nil
    let nibName = "MemoEntryView"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    @IBAction func edit(_ sender: Any) {
        viewControllerDelegate?.editMemo(memo: memo!)
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: nibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setRoundedTimeLabelCorners()
    }
    
    private func setRoundedTimeLabelCorners() {
        timeLabel?.layer.masksToBounds = true
        timeLabel?.layer.cornerRadius = 8.0
    }
    
    func configureView(memo: Memo, viewControllerDelegate: ViewController) {
        timeLabel.text = memo.date?.formatedTime
        contentTextLabel.text = memo.content!
        self.memo = memo
        self.viewControllerDelegate = viewControllerDelegate
    }
    
}
