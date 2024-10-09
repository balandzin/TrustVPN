import UIKit

extension UILabel {
    func addGradientOverlay(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        // Создаем маску
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        maskLayer.contents = self.layer.contents

        gradientLayer.mask = maskLayer
        
        // Удаляем предыдущий градиент, если он есть
        self.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // Добавляем градиентный слой в label
        self.layer.addSublayer(gradientLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем градиентный слой при изменении размера
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = self.bounds
        }
    }
}
