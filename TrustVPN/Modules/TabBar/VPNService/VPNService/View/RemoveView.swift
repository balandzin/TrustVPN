import UIKit

final class RemoveView: UIView {
    
    // MARK: - GUI Variables
    lazy var closeButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.closeButton) ?? UIImage(named: "closeButton")
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.cancel, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.remove, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.backgroundColor = AppColors.loadingIndicator
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 22
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingBar
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var removeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = AppText.removeServer + "?"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.text = AppText.removeDescription
        return label
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        containerView.addSubview(removeLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(cancelButton)
        containerView.addSubview(removeButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(210)
        }
        
        removeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(removeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(removeButton)
            make.trailing.equalTo(containerView.snp.centerX)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.leading.equalTo(containerView.snp.centerX)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
    }
}
