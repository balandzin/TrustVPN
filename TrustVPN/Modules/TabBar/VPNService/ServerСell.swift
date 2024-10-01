import UIKit

final class ServerСell: UITableViewCell {
    
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var serverName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.backgroundColor = AppColors.termsAcceptButton
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupCell(model: VpnServers) {
        flagImage.image = .loadImage(model.countryImageMin) ?? UIImage(named: "deleteIMG")
        serverName.text = model.countryName
        
        
        
        
    }
    
    // MARK: - ObjC Methods
    @objc private func selectButtonTapped() {
        print("selectButtonTapped")
    }
    
    // MARK: - Private Methods
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(flagImage)
        containerView.addSubview(serverName)
        containerView.addSubview(selectButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview().inset(10)
        }
        
        flagImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(40)
        }
        
        serverName.snp.makeConstraints { make in
            make.centerY.equalTo(flagImage)
            make.leading.equalTo(flagImage.snp.trailing).offset(10)
            make.trailing.equalTo(selectButton.snp.leading).offset(-10)
        }
        
        selectButton.snp.makeConstraints { make in
            make.centerY.equalTo(flagImage)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(94)
            make.height.equalTo(40)
        }
    }
}
