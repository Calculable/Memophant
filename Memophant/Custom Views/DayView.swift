import UIKit

@IBDesignable
final class DayView: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var memoEntryStackView: UIStackView!
    
    var viewControllerDelegate: ViewController? = nil
    let dayView = "DayView"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: dayView) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setShadow()
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
    
    func configureView(day: String, memos: [Memo], viewControllerDelegate: ViewController) {
        label.text = day
        memos.forEach { memo in
            let entry = MemoEntryView()
            entry.configureView(memo: memo, viewControllerDelegate: viewControllerDelegate)
            memoEntryStackView.addArrangedSubview(entry)
        }
    }

}
