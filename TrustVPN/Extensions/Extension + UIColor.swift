import Foundation
import SwiftUI
import UIKit

extension UIColor {
    
//    convenience init(hex: String, alpha: CGFloat = 1) {
//        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }
//        
//        var rgbValue: UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//        
//        self.init(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(alpha)
//        )
//    }
//    
//    static func gradientColor(start: UIColor, end: UIColor, locations: [NSNumber]) -> UIColor {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [start.cgColor, end.cgColor]
//        gradientLayer.locations = locations
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
//        
//        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
//        guard let context = UIGraphicsGetCurrentContext() else { return UIColor.clear }
//        gradientLayer.render(in: context)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return UIColor(patternImage: image!)
//    }
//    
//    static var gradientColor: UIColor {
//        return gradientColor(start: UIColor(hex: "#0093E5", alpha: 0.04), end: UIColor(hex: "#0093E5", alpha: 0.04), locations: [0.02, 0.04])
//    }
    
//    convenience init(hex: String, alpha: CGFloat = 1) {
//            var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//            if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }
//            
//            var rgbValue: UInt64 = 0
//            Scanner(string: cString).scanHexInt64(&rgbValue)
//            
//            self.init(
//                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//                alpha: alpha
//            )
//        }
//        
//        static func gradientBackground(primaryColor: UIColor, secondaryColor: UIColor) -> UIColor {
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [
//                primaryColor.cgColor,
//                secondaryColor.withAlphaComponent(0.02).cgColor,
//                secondaryColor.withAlphaComponent(0.04).cgColor
//            ]
//            
//            // Указываем расположение градиента
//            gradientLayer.locations = [0.0, 0.5, 1.0]
//            
//            // Настраиваем начало и конец градиента
//            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.6)
//            
//            // Создаем изображение с большим разрешением (например, 200x200 пикселей)
//            let size = CGSize(width: 200, height: 200)
//            UIGraphicsBeginImageContext(size)
//            gradientLayer.frame = CGRect(origin: .zero, size: size)
//            
//            guard let context = UIGraphicsGetCurrentContext() else { return UIColor.clear }
//            gradientLayer.render(in: context)
//            
//            let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            // Проверяем, удалось ли создать изображение
//            guard let image = gradientImage else { return UIColor.clear }
//            
//            // Превращаем изображение в паттерн
//            return UIColor(patternImage: image)
//        }
//        
//        static var gradientColor: UIColor {
//            // Primary: #181818, Secondary: #262626
//            let primaryColor = UIColor(hex: "#181818")
//            let secondaryColor = UIColor(hex: "#262626")
//            
//            return gradientBackground(primaryColor: primaryColor, secondaryColor: secondaryColor)
//        }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
            var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }
            
            var rgbValue: UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        }
        
        static func gradientBackground(primaryColor: UIColor, secondaryColor: UIColor) -> UIColor {
            // Создаем CAGradientLayer для наложения градиента
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                primaryColor.cgColor,
                secondaryColor.withAlphaComponent(0.02).cgColor, // слева 2% прозрачности
                secondaryColor.withAlphaComponent(0.04).cgColor  // справа 4% прозрачности
            ]
            
            // Настраиваем расположение градиента: слева 2%, справа 4%
            gradientLayer.locations = [0.0, 0.5, 1.0]
            
            // Настраиваем фрейм для получения градиента в виде изображения
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // Начало по центру слева
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // Конец по центру справа
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            
            // Создаем изображение из градиента
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            guard let context = UIGraphicsGetCurrentContext() else { return UIColor.clear }
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Возвращаем цвет в виде паттерна на основе изображения
            return UIColor(patternImage: image!)
        }
        
        static var gradientColor: UIColor {
            let primaryColor = UIColor(hex: "#181818") // Основной цвет
            let secondaryColor = UIColor(hex: "#262626") // Второстепенный цвет
            
            return gradientBackground(primaryColor: primaryColor, secondaryColor: secondaryColor)
        }
}
