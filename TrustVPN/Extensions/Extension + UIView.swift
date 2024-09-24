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
