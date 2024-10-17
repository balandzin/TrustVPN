import UIKit
import Network

final class SearchBottomSheetController: BottomSheetController {
    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20.vertical
        view.backgroundColor = AppColors.termsView
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var cancelView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.closeButton) ?? UIImage(named: "closeButton")
        image.contentMode = .scaleAspectFit
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        image.addGestureRecognizer(recognizer)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var indicatorImageView: UIImageView = {
        let image = UIImageView(image: images[0].indicator)
        return image
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: images[0].image)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = images[0].title
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = images[0].subTitle
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.continueButton, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.loadingIndicator
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: SearchRequiredControllerDelegate?
    private var currentIndex = 0
    
    private var images: [
        (indicator: UIImage, image: UIImage, title: String, subTitle: String)] = [
            (
                indicator: .loadImage(LoadService.shared.load?.images?.indicatorLeft) ?? 
                UIImage(imageLiteralResourceName: "indicatorLeft"),
                image: .loadImage(LoadService.shared.load?.images?.welcomeImage) ??
                UIImage(imageLiteralResourceName: "welcomeImage"),
                title: AppText.welcomeToDeviceSearch,
                subTitle: AppText.welcomeToPasswordSecurityDescription
            ),
            (
                indicator: .loadImage(LoadService.shared.load?.images?.indicatorRight) ?? 
                UIImage(imageLiteralResourceName: "indicatorRight"),
                image: .loadImage(LoadService.shared.load?.images?.searchIndicator) ?? 
                UIImage(imageLiteralResourceName: "searchIndicator"),
                title: AppText.informationOnTheIndicator,
                subTitle: AppText.indicatorDescription
            )
        ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(containerView)
        containerView.addSubview(cancelView)
        containerView.addSubview(indicatorImageView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(continueButton)
        
        setupConstraints()
    }
    
    private func updateContent() {
        indicatorImageView.image = images[currentIndex].indicator
        imageView.image = images[currentIndex].image
        titleLabel.text = images[currentIndex].title
        subTitleLabel.text = images[currentIndex].subTitle
        
        UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.imageView.image = self.images[self.currentIndex].image
        }, completion: nil)
        
        UIView.transition(with: titleLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.titleLabel.text = self.images[self.currentIndex].title
        }, completion: nil)
        
        UIView.transition(with: subTitleLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.subTitleLabel.text = self.images[self.currentIndex].subTitle
        }, completion: nil)
        
        UIView.transition(with: indicatorImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.indicatorImageView.image = self.images[self.currentIndex].indicator
        }, completion: nil)
        
        if currentIndex == 1 {
            continueButton.setTitle(AppText.goToUse, for: .normal)
        } else {
            continueButton.setTitle(AppText.continueButton, for: .normal)
        }
    }
    
    @objc func continueButtonTapped() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
            updateContent()
        } else {
            dismiss(animated: true)
            delegate?.didTapContinue(index: 1)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(600)
        }
        
        cancelView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cancelView)
            make.centerX.equalToSuperview()
            make.width.equalTo(54)
            make.height.equalTo(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(indicatorImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(338)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
