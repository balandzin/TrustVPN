import Foundation
import SnapKit
import UIKit

extension UIView {
    
    func rotateDegrees(duration: CGFloat = 2) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func pulseAnimation(duration: CGFloat = 2) {
        self.layer.removeAnimation(forKey: "scaleAnimation")
        
        let scaling = CABasicAnimation(keyPath: "transform.scale")
        scaling.toValue = 0.9
        scaling.fromValue = 1
        scaling.duration = duration
        scaling.autoreverses = true
        scaling.repeatCount = .infinity
        self.layer.add(scaling, forKey: "scaleAnimation")
    }
    
    func removeDegrees() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
        self.layer.removeAnimation(forKey: "scaleAnimation")
    }
    
    func event(events: UIControl.Event = .touchUpInside, isAnimate: Bool = false, _ closure: @escaping()->()) {
        isUserInteractionEnabled = true
        
        let button = UIButton()
        button.backgroundColor = .clear
        button.removeFromSuperview()
        addSubview(button)
        
        button.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let action = UIAction { _ in
            if isAnimate {
                UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction) {
                    self.transform = .init(scaleX: 0.95, y: 0.95)
                } completion: { _ in
                    UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction) {
                        self.transform = .init(scaleX: 1, y: 1)
                    }
                }
            }
            self.endEditing(true)
            UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.6)
            closure()
        }
        
        button.addAction(action, for: events)
    }
    
    func eventNew(events: UIControl.Event = .touchUpInside, isAnimate: Bool = false, _ closure: @escaping()->()) {
        isUserInteractionEnabled = true
        
        let button = UIButton()
        button.backgroundColor = .clear
        button.removeFromSuperview()
        insertSubview(button, at: 0)
        
        button.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let action = UIAction { _ in
            if isAnimate {
                UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction) {
                    self.transform = .init(scaleX: 0.95, y: 0.95)
                } completion: { _ in
                    UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction) {
                        self.transform = .init(scaleX: 1, y: 1)
                    }
                }
            }
            self.endEditing(true)
            UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.6)
            closure()
        }
        
        button.addAction(action, for: events)
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.height.equalTo(height)
        }
        return self
    }
    
    @discardableResult
    func heightMin(_ height: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.height.greaterThanOrEqualTo(height)
        }
        return self
    }
    
    @discardableResult
    func heightAndWidthMax(height: CGFloat, width: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.height.equalTo(height)
            make.width.lessThanOrEqualTo(width)
        }
        return self
    }
    
    @discardableResult
    func heightAndWidth(height: CGFloat, width: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.width.equalTo(width)
        }
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> UIView {
        self.snp.remakeConstraints { make in
            make.size.equalTo(size)
        }
        return self
    }
    
    @discardableResult
    func size(_ size: CGFloat) -> UIView {
        self.snp.remakeConstraints { make in
            make.size.equalTo(size)
        }
        return self
    }
}

extension UIView {
    static func applyCustomGradient(to view: UIView) {
        let primaryColor = UIColor(hex: "#181818")
        let secondaryColor = UIColor(hex: "#262626")
        
        if let previousGradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            previousGradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            primaryColor.cgColor,
            secondaryColor.withAlphaComponent(0.02).cgColor,
            secondaryColor.withAlphaComponent(0.04).cgColor
        ]
        
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let leftCircleLayer = CAShapeLayer()
        let leftCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.width * 0.25, y: view.bounds.height * 0.5), radius: view.bounds.width * 0.3, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        leftCircleLayer.path = leftCirclePath.cgPath
        leftCircleLayer.fillColor = secondaryColor.withAlphaComponent(0.02).cgColor
        
        let rightCircleLayer = CAShapeLayer()
        let rightCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.width * 0.75, y: view.bounds.height * 0.3), radius: view.bounds.width * 0.4, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        rightCircleLayer.path = rightCirclePath.cgPath
        rightCircleLayer.fillColor = secondaryColor.withAlphaComponent(0.04).cgColor
        
        view.layer.insertSublayer(leftCircleLayer, at: 1)
        view.layer.insertSublayer(rightCircleLayer, at: 2)
    }
}

extension UIView {
    
    func applyDefaultBackgroundImage() {
        let backgroundImage = .loadImage(LoadService.shared.load?.images?.background) ?? UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = self.bounds
        backgroundImageView.clipsToBounds = true
        
        self.subviews.forEach { subview in
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
        
        self.insertSubview(backgroundImageView, at: 0)
    }
}
