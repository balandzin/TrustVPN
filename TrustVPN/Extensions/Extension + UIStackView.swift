import Foundation
import UIKit

extension UIStackView {
    
    convenience init(ax: NSLayoutConstraint.Axis, alignm: UIStackView.Alignment, distr: UIStackView.Distribution) {
        self.init(frame: .zero)
        self.axis = ax
        self.alignment = alignm
        self.distribution = distr
        self.backgroundColor = .clear
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}
