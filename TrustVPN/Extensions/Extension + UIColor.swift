import Foundation
import SwiftUI
import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static func gradientColor(start: UIColor, end: UIColor, locations: [NSNumber]) -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [start.cgColor, end.cgColor]
        gradientLayer.locations = locations
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else { return UIColor.clear }
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image!)
    }
    
    static var gradientColor: UIColor {
        return gradientColor(start: UIColor(hex: "#0093E5", alpha: 0.04), end: UIColor(hex: "#0093E5", alpha: 0.04), locations: [0.02, 0.04])
    }
}
