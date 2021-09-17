import Foundation
import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
            let topOffset = CGPoint(x: 0, y: -contentInset.top)
            setContentOffset(topOffset, animated: animated)
        }
}
