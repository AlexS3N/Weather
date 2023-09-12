
import UIKit

extension UIView {
    func backgroundAnimate(_ background: UIView) {
        background.frame.origin.x = 0
        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .autoreverse], animations: {background.frame.origin.x -= 100}, completion: nil)
    }
}
