import Foundation
import UIKit

extension UITextField {
    var placeHolderColor: UIColor? {
        get {
            if let attributedText = self.attributedPlaceholder,
               let color = attributedText.attributes(at: 0, effectiveRange: nil)[.foregroundColor] as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let placeholderText = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(
                    string: placeholderText,
                    attributes: [NSAttributedString.Key.foregroundColor: newValue ?? UIColor.clear]
                )
            }
        }
    }
}
