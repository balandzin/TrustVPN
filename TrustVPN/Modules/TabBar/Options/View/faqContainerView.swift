import UIKit
import SnapKit

final class faqContainerView: UIView {

    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.loadImage(LoadService.shared.load?.images?.passwordSecurityDown) ?? UIImage(named: "passwordSecurityDown"), for: .normal)
        button.tintColor = AppColors.dataSecurityLabel
        button.touchAreaInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        return button
    }()

    // MARK: - Initializers
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        backgroundColor = AppColors.loadingBar
        layer.cornerRadius = 26
        isUserInteractionEnabled = true
        
        addSubview(titleLabel)
        addSubview(openButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        openButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(12)
            make.height.equalTo(6)
        }
    }
}
