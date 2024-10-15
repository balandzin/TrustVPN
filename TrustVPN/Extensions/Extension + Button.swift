import UIKit
import ObjectiveC.runtime

extension UIButton {
    private struct AssociatedKeys {
        static var touchAreaInsets = UIEdgeInsets()
    }

    var touchAreaInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.touchAreaInsets) as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.touchAreaInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let insets = touchAreaInsets else {
            return super.point(inside: point, with: event)
        }
        let largerFrame = bounds.inset(by: insets)
        return largerFrame.contains(point)
    }
}
