import UIKit

final class ServerAddedView: UIView {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var serverAddedView: UIImageView = {
        let view = UIImageView()
        view.image = .loadImage(LoadService.shared.load?.images?.vpnServerAdded) ?? UIImage(named: "vpnServerAdded")
        view.tintColor = AppColors.almostWhite
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(serverAddedView)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        serverAddedView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(264)
        }
    }
}
