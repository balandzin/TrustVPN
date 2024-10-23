import UIKit

final class ChangeIconController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - GUI Variables
    private lazy var backButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.сhooseServerBackButton) ??
        UIImage(named: "сhooseServerBackButton")
        button.tintColor = AppColors.dataSecurityLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        button.addGestureRecognizer(tap)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.changeIcon
        label.textColor = AppColors.almostWhite
        label.textAlignment = .center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var currentIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var currentIconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.currentIcon
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = AppColors.almostWhite
        return label
    }()
    
    private lazy var currentIconNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = AppColors.dataSecurityLabel
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dataSecurityLabel.withAlphaComponent(0.1)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var iconVariantsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = AppText.iconVariants
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = AppColors.almostWhite
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        return collectionView
    }()
    
    let icons: [(name: String, icon: UIImage?)] = [
        (name: AppText.classic, icon: .loadImage(LoadService.shared.load?.images?.classic) ?? UIImage(named: "classic")),
        (name: AppText.dynamic, icon: .loadImage(LoadService.shared.load?.images?.dynamic) ?? UIImage(named: "dynamic")),
        (name: AppText.advanced, icon: .loadImage(LoadService.shared.load?.images?.advanced) ?? UIImage(named: "advanced")),
        (name: AppText.abstraction, icon: .loadImage(LoadService.shared.load?.images?.abstraction) ?? UIImage(named: "abstraction")),
        (name: AppText.modern, icon: .loadImage(LoadService.shared.load?.images?.modern) ?? UIImage(named: "modern"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
        updateCurrentIcon()
    }
    
    // MARK: - Private Methods
    private func setupStyle() {
        view.applyDefaultBackgroundImage()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(containerView)
        containerView.addSubview(currentIconImageView)
        containerView.addSubview(currentIconLabel)
        containerView.addSubview(currentIconNameLabel)
        view.addSubview(separatorView)
        view.addSubview(iconVariantsLabel)
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func updateCurrentIcon() {
        let iconName = UIApplication.shared.alternateIconName?.lowercased()
        
        if let iconName = iconName, let matchingIcon = icons.first(where: { $0.name.lowercased() == iconName }) {
            currentIconImageView.image = matchingIcon.icon
            currentIconNameLabel.text = iconName.capitalized
        } else {
            currentIconImageView.image = .loadImage(LoadService.shared.load?.images?.classic) ?? UIImage(named: "classic")
            currentIconNameLabel.text = AppText.classic
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Change App Icon
    private func changeAppIcon(to iconName: String?) {
        guard let name = iconName?.lowercased() else { return }
        guard UIApplication.shared.supportsAlternateIcons else {
            print("Устройство не поддерживает смену иконок")
            return
        }
        
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print("Error changing app icon: \(error.localizedDescription)")
            } else {
                self.updateCurrentIcon()
                print("Иконка успешно изменена на \(iconName ?? "основную")")
            }
        }
    }
}

extension ChangeIconController {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        let icon = icons[indexPath.item]
        cell.configure(with: icon)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIcon = icons[indexPath.item]
        changeAppIcon(to: selectedIcon.name)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 124, height: 156)
    }
}

extension ChangeIconController {
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(40)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(headerLabel.snp.bottom).offset(40)
            make.height.equalTo(144)
        }
        
        currentIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(104)
        }
        
        currentIconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(currentIconImageView.snp.centerY).offset(-5)
        }
        
        currentIconNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(currentIconImageView.snp.centerY).offset(5)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        iconVariantsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(separatorView.snp.bottom).offset(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(iconVariantsLabel.snp.bottom).offset(20)
            make.height.equalTo(156)
        }
    }
}
