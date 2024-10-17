import UIKit

final class GradientProgressView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CALayer()
    
    private var progress: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 4
        gradientLayer.masksToBounds = true
        layer.addSublayer(gradientLayer)
        
        maskLayer.backgroundColor = UIColor.black.cgColor
        gradientLayer.mask = maskLayer
        
        progress = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updateProgress(animated: false)
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        self.progress = max(0, min(1, progress))
        updateProgress(animated: animated)
    }
    
    private func updateProgress(animated: Bool) {
        let newWidth = bounds.width * progress
        
        if animated {
            let animation = CABasicAnimation(keyPath: "bounds.size.width")
            animation.fromValue = maskLayer.bounds.width
            animation.toValue = newWidth
            animation.duration = 0.3
            maskLayer.add(animation, forKey: "bounds.size.width")
        }
        
        maskLayer.frame = CGRect(x: 0, y: 0, width: newWidth, height: bounds.height)
    }
}
