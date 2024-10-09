import SnapKit
import UIKit

final class OnboardViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: images[0].icon)
        image.contentMode = .scaleToFill
        
        return image
    }()
    
    private let infoView = InfoView()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.continueButton, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.termsAcceptButton
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    private var currentIndex = 0
    
    // MARK: - Private Properties
    private var images: [(icon: UIImage, title: String, subTitle: String)] = [(icon: .loadImage(LoadService.shared.load?.images?.onboard1) ?? UIImage(imageLiteralResourceName: "onboard1"), title: AppText.onboard1Title, subTitle: AppText.onboard1SubTitle), (icon: .loadImage(LoadService.shared.load?.images?.onboard2) ?? UIImage(imageLiteralResourceName: "onboard2"), title: AppText.onboard2Title, subTitle: AppText.onboard2SubTitle), (icon: .loadImage(LoadService.shared.load?.images?.onboard3) ?? UIImage(imageLiteralResourceName: "onboard3"), title: AppText.onboard3Title, subTitle: AppText.onboard3SubTitle)]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.info(title: images[0].title, subTitle: images[0].subTitle)
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        
        infoView.info(title: images[0].title, subTitle: images[0].subTitle)
        view.addSubview(imageView)
        view.addSubview(infoView)
        view.addSubview(continueButton)
        setupConstraints()
        addSwiper()
    }
    
    private func addSwiper() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15.vertical)
            make.height.equalTo(410)
            make.leading.equalTo(view.snp.leading).inset(24)
            make.trailing.equalTo(view.snp.trailing).inset(24)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(35.vertical)
        }
    }
    
    private func updateContent() {
        imageView.image = images[currentIndex].icon
        infoView.info(title: images[currentIndex].title, subTitle: images[currentIndex].subTitle)
        
        UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.imageView.image = self.images[self.currentIndex].icon
        }, completion: nil)
        
        UIView.transition(with: infoView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.infoView.info(title: self.images[self.currentIndex].title, subTitle: self.images[self.currentIndex].subTitle)
        }, completion: nil)
    }
    
    // MARK: - Objc Methods
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentIndex < images.count - 1 {
                currentIndex += 1
                updateContent()
            }
        } else if gesture.direction == .right {
            if currentIndex > 0 {
                currentIndex -= 1
                updateContent()
            }
        }
    }
    
    @objc func continueButtonTapped() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
            updateContent()
        } else {
            showTabBarController()
        }
    }
}

extension OnboardViewController {
    private func showTabBarController() {
        let tabBarController = TabBarController()
        let newNavigationController = UINavigationController(rootViewController: tabBarController)
        newNavigationController.isNavigationBarHidden = true
        newNavigationController.modalPresentationStyle = .fullScreen
        newNavigationController.modalTransitionStyle = .crossDissolve
        navigationController?.present(newNavigationController, animated: false)
    }
     
//    //ДОБАВИТЬ ЛОКАЛИЗАЦИЮ TITLE
//    private func createViewControllers(_ tabBarController: TabBarController) {
//        tabBarController.viewControllers = [
//            UIViewController.createNavController(
//                for: VPNServiceController(),
//                image: (.loadImage(LoadService.shared.load?.images?.vpnService) ?? UIImage(named: "vpnService")) ?? UIImage(),
//                tag: 0
//            ),
//            UIViewController.createNavController(
//                for: DeviceSearchController(),
//                image: (.loadImage(LoadService.shared.load?.images?.deviceSearch) ?? UIImage(named: "deviceSearch")) ?? UIImage(),
//                tag: 1
//            ),
//            UIViewController.createNavController(
//                for: PasswordSecurityController(),
//                image: (.loadImage(LoadService.shared.load?.images?.passwordSecurity) ?? UIImage(named: "passwordSecurity")) ?? UIImage(),
//                tag: 2
//            ),
//            UIViewController.createNavController(
//                for: OptionsController(),
//                image: (.loadImage(LoadService.shared.load?.images?.options) ?? UIImage(named: "options")) ?? UIImage(),
//                tag: 3
//            )
//        ]
//    }
}
