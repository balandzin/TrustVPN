import Foundation
import UIKit

extension UITextField {
    
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        } set {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder != nil ? self.placeholder! : "",
                attributes:[NSAttributedString.Key.foregroundColor: newValue!]
            )
        }
    }
}
