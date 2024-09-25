import Foundation
import UIKit

enum FontType: String {
    case rammetoRegular = "RammettoOne-Regular"
    case sansitaRegular = "SansitaOne-Regular"
}

extension UIFont {
    
    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont()
    }
}

