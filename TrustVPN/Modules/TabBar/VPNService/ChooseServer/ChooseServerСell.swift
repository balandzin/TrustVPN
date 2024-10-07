import UIKit

final class ChooseServerСell: UITableViewCell {
    
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
    
    lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.backgroundColor = AppColors.termsAcceptButton
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 20
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



class ViewController: UIViewController {
    
    var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание кнопки с тремя точками
        let dotsButton = UIButton(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        dotsButton.setImage(UIImage(named: "threeDots"), for: .normal) // Замените "threeDots" на ваше изображение
        dotsButton.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        self.view.addSubview(dotsButton)
        
        // Создание всплывающего окна
        setupPopupView()
    }
    
    @objc func showPopup() {
        self.popupView.isHidden.toggle() // Показываем или скрываем окно
    }
    
    func setupPopupView() {
        let popupWidth: CGFloat = 184
        let popupHeight: CGFloat = 145
        
        popupView = UIView(frame: CGRect(x: 100, y: 150, width: popupWidth, height: popupHeight))
        popupView.backgroundColor = .white
        popupView.layer.borderColor = UIColor.black.cgColor
        popupView.layer.borderWidth = 1
        popupView.layer.cornerRadius = 10
        
        // Кнопка "Rename Server"
        let renameButton = UIButton(frame: CGRect(x: 10, y: 20, width: popupWidth - 20, height: 40))
        renameButton.setTitle("Rename Server", for: .normal)
        renameButton.setTitleColor(.blue, for: .normal)
        renameButton.addTarget(self, action: #selector(renameServer), for: .touchUpInside)
        
        // Кнопка "Remove from List"
        let removeButton = UIButton(frame: CGRect(x: 10, y: 80, width: popupWidth - 20, height: 40))
        removeButton.setTitle("Remove from List", for: .normal)
        removeButton.setTitleColor(.red, for: .normal)
        removeButton.addTarget(self, action: #selector(removeFromList), for: .touchUpInside)
        
        popupView.addSubview(renameButton)
        popupView.addSubview(removeButton)
        popupView.isHidden = true // Скрываем окно по умолчанию

        self.view.addSubview(popupView)
        
        // Добавление жеста для скрытия
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func renameServer() {
        print("Rename Server tapped")
        popupView.isHidden = true
    }
    
    @objc func removeFromList() {
        print("Remove from List tapped")
        popupView.isHidden = true
    }
    
    @objc func dismissPopup() {
        popupView.isHidden = true
    }
}
