import UIKit
import SnapKit

final class ServerNotSelectedView: UIView {
    // MARK: - GUI Variables
    lazy var selectServerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.selectServer, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.loadingIndicator
        button.layer.cornerRadius = 22
        return button
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image =  .loadImage(LoadService.shared.load?.images?.serverNotSelected) ?? UIImage(named: "serverNotSelected")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.serverNotSelected
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.serverNotSelectedDescription
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
        backgroundColor = .clear
        addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(selectServerButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(181)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(40)
            make.centerX.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        selectServerButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(174)
            make.height.equalTo(44)
        }
    }
}
