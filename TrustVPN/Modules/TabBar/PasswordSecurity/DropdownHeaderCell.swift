import UIKit

final class DropdownHeaderCell: UITableViewCell {
    
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.passwordSecurity
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.loadImage(LoadService.shared.load?.images?.passwordSecurityDown) ?? UIImage(named: "passwordSecurityDown"), for: .normal)
        button.tintColor = AppColors.dataSecurityLabel
        button.touchAreaInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupCell(title: String, isSectionOpen: Bool) {
        if isSectionOpen {
            openButton.setImage(.loadImage(LoadService.shared.load?.images?.passwordSecurityUp) ?? UIImage(named: "passwordSecurityUp"), for: .normal)
        } else {
            openButton.setImage(.loadImage(LoadService.shared.load?.images?.passwordSecurityDown) ?? UIImage(named: "passwordSecurityDown"), for: .normal)
        }
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .clear
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(openButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(40)
        }
        
        openButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(12)
            make.height.equalTo(6)
        }
    }
}
