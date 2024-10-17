import UIKit

final class RenameView: UIView, UITextFieldDelegate {
    
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
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.save, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.backgroundColor = AppColors.loadingIndicator
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 22
        return button
    }()
    
    lazy var renameTextField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = AppText.renameServerPlaceholder
        textField.placeHolderColor = AppColors.dataSecurityLabel
        textField.font = .systemFont(ofSize: 14, weight: .bold)
        textField.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        textField.textColor = AppColors.almostWhite
        textField.layer.cornerRadius = 10
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = AppColors.textFieldBackground
        return textField
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.swipeBackground
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var renameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = AppText.renameServer
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSaveButtonState()
        return true
    }
    
    // MARK: - Private Methods
    private func updateSaveButtonState() {
        if let text = renameTextField.text, !text.isEmpty {
            saveButton.isEnabled = true
            saveButton.alpha = 1.0
        } else {
            saveButton.isEnabled = false
            saveButton.alpha = 0.5
        }
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        containerView.addSubview(renameLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(renameTextField)
        containerView.addSubview(cancelButton)
        containerView.addSubview(saveButton)
        
        renameTextField.delegate = self
        updateSaveButtonState()
        setupConstraints()
        
    }
}

// MARK: - Setup Constraints
extension RenameView {
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(210)
        }
        
        renameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.centerX.equalToSuperview()
        }
        
        renameTextField.snp.makeConstraints { make in
            make.top.equalTo(renameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(46)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(saveButton)
            make.trailing.equalTo(containerView.snp.centerX)
        }
        
        saveButton.snp.makeConstraints { make in
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
