import UIKit

final class SwipeConnectView: UIView {
    enum SwipeConnectViewType {
        case off
        case on
        
        var titleImage: UIImage {
            switch self {
            case .off:
                return (.loadImage(LoadService.shared.load?.images?.swipeToConnect)
                        ?? UIImage(named: "swipeToConnect")) ?? UIImage()
            case .on:
                return (.loadImage(LoadService.shared.load?.images?.swipeToDisconnect)
                        ?? UIImage(named: "swipeToDisconnect")) ?? UIImage()
            }
        }
        
        var titleDescription: String {
            switch self {
            case .off:
                return AppText.swipeToConnect
            case .on:
                return AppText.swipeToDisconnect
            }
        }
        
        var icon: UIImage {
            switch self {
            case .off:
                return (.loadImage(LoadService.shared.load?.images?.disconnectedImage)
                        ?? UIImage(named: "disconnectedImage")) ?? UIImage()
            case .on:
                return (.loadImage(LoadService.shared.load?.images?.connectedImage)
                        ?? UIImage(named: "connectedImage")) ?? UIImage()
            }
        }
    }
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView(image: type.icon)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var titleView: UIImageView = {
        let image = UIImageView(image: type.titleImage)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let type: SwipeConnectViewType
    var connected: ((Bool) -> Void)?
    
    init(type: SwipeConnectViewType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setupConstraints()
        addSwipeGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func type(_ type: SwipeConnectViewType, isAnimate: Bool) {
        if isAnimate {
            iconView.image = type.icon
            titleView.image = type.titleImage
            titleLabel.text = type.titleDescription
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction) {
                self.iconView.snp.remakeConstraints { make in
                    if type == .on {
                        make.centerY.equalTo(self)
                        make.trailing.equalTo(self).offset(-6)
                    } else {
                        make.centerY.equalTo(self)
                        make.leading.equalTo(self).offset(6)
                    }
                }
                self.titleLabel.snp.remakeConstraints { make in
                    if type == .on {
                        make.centerY.equalTo(self)
                        make.trailing.equalTo(self.iconView.snp.leading).offset(-10)
                        make.width.equalTo(120)
                    } else {
                        make.centerY.equalTo(self)
                        make.leading.equalTo(self.iconView.snp.trailing).offset(10)
                        make.width.equalTo(120)
                    }
                }
                
                self.titleView.snp.remakeConstraints { make in
                    if type == .on {
                        make.centerY.equalTo(self)
                        make.trailing.equalTo(self.titleLabel.snp.leading).offset(-10)
                        make.width.equalTo(40)
                        make.height.equalTo(16)
                    } else {
                        make.centerY.equalTo(self)
                        make.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
                        make.width.equalTo(40)
                        make.height.equalTo(16)
                    }
                }
                self.layoutIfNeeded()
            }
        } else {
            iconView.image = type.icon
            titleView.image = type.titleImage
            titleLabel.text = type.titleDescription
            
            self.iconView.snp.remakeConstraints { make in
                if type == .on {
                    make.centerY.equalTo(self)
                    make.trailing.equalTo(self).offset(-6)
                } else {
                    make.centerY.equalTo(self)
                    make.leading.equalTo(self).offset(6)
                }
            }
            self.titleLabel.snp.remakeConstraints { make in
                if type == .on {
                    make.centerY.equalTo(self)
                    make.trailing.equalTo(self.iconView.snp.leading).offset(-10)
                    make.width.equalTo(120)
                } else {
                    make.centerY.equalTo(self)
                    make.leading.equalTo(self.iconView.snp.trailing).offset(10)
                    make.width.equalTo(120)
                }
            }
            
            self.titleView.snp.remakeConstraints { make in
                if type == .on {
                    make.centerY.equalTo(self)
                    make.trailing.equalTo(self.titleLabel.snp.leading).offset(-10)
                    make.width.equalTo(40)
                    make.height.equalTo(16)
                } else {
                    make.centerY.equalTo(self)
                    make.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
                    make.width.equalTo(40)
                    make.height.equalTo(16)
                }
            }
        }
    }
    
    private func setupConstraints() {
        addSubview(iconView)
        addSubview(titleView)
        addSubview(titleLabel)
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(iconView.snp.trailing).offset(10)
            make.width.equalTo(120)
        }
        
        titleView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(16)
        }
    }
    
    private func addSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAll))
        swipeRight.direction = .left
        swipeRight.cancelsTouchesInView = false
        iconView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAll))
        swipeLeft.direction = .right
        swipeLeft.cancelsTouchesInView = false
        iconView.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func swipeGestureAll(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            generateHapticFeedback()
            self.type(.on, isAnimate: true)
            self.connected?(true)
        case .left:
            generateHapticFeedback()
            self.type(.off, isAnimate: true)
            self.connected?(false)
        default:
            break
        }
    }
    
    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
