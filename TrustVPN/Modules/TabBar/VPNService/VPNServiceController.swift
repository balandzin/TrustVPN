import UIKit

final class VPNServiceController: UIViewController {
    
    // GUI Variables
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.vpnService
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var plusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "plus")
        image.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        return image
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "serverNotSelected")
        return image
    }()
    
    private lazy var selectServerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.selectServer, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.termsAcceptButton
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    // MARK: - ObjC Methods
    @objc private func buttonTapped() {
        navigationController?.pushViewController(ChooseServerController(), animated: false)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(plusImage)
        view.addSubview(image)
        view.addSubview(selectServerButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        plusImage.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(267)
        }
        
        selectServerButton.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.width.equalTo(174)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
}
