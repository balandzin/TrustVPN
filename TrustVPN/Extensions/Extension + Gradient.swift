import Foundation
import UIKit

enum CAGradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

extension CAGradientLayer {
    
    convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], locations: [NSNumber] = [0, 1]) {
        self.init()
        self.frame.origin = CGPoint.zero
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = locations
    }
}

extension UIView {
    
    func layerGradient(startPoint: CAGradientPoint, endPoint: CAGradientPoint, colorArray: [CGColor], locations: [NSNumber] = [0, 1]) {
        self.removeGradient()
        let gradient = CAGradientLayer(start: startPoint, end: endPoint, colors: colorArray, locations: locations)
        gradient.frame.size = self.frame.size
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradient() {
        layer.sublayers?.forEach { sublayer in
            if sublayer is CAGradientLayer {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}

extension CGPoint {
    
    enum CoordinateSide {
        case topLeft
        case top
        case topRight
        case right
        case bottomRight
        case bottom
        case bottomLeft
        case left
    }
    
    static func unitCoordinate(_ side: CoordinateSide) -> CGPoint {
        let x: CGFloat
        let y: CGFloat
        
        switch side {
        case .topLeft:
            x = 0.0
            y = 0.0
        case .top:
            x = 0.5
            y = 0.0
        case .topRight:
            x = 1.0
            y = 0.0
        case .right:
            x = 0.0
            y = 0.5
        case .bottomRight:
            x = 1.0
            y = 1.0
        case .bottom:
            x = 0.5
            y = 1.0
        case .bottomLeft:
            x = 0.0
            y = 1.0
        case .left:
            x = 1.0
            y = 0.5
        }
        return .init(x: x, y: y)
    }
}
