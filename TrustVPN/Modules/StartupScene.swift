import UIKit
import SnapKit

final class StartupScene: UIViewController {
    
    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "startupBackground")
        return image
    }()
    
    private lazy var centralLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "centralLogo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var loadingBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingBar
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var  loadingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingIndicator
        view.layer.cornerRadius = 3
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadServer__asl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    // MARK: - Private Functions
    private func loadServer__asl() {
//        LoadService.shared.get { [weak self] model in
//            guard let self = self else { return }
//            LoadService.shared.load = model
//            self.loadVpnServers()
//            self.getStatusVpn()
//            self.showLastScene()
//        } errorComplition: { [weak self] in
//            guard let self = self else { return }
//            
//            let ac = UIAlertController(
//                title: "Sorry",
//                message: "The app is undergoing technical work. We will finish soon and you will be able to use the app again :)",
//                preferredStyle: .actionSheet
//            )
//            
//            ac.addAction(
//                UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
//                    self.loadServer__asl()
//                }))
//            
//            self.present(ac, animated: true)
//        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(centralLogo)
        imageView.addSubview(loadingBar)
        loadingBar.addSubview(loadingIndicator)
        
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        centralLogo.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(114)
            make.height.equalTo(114)
        }
        
        loadingBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(6)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(6)
        }
        
    }
    
    private func startAnimation() {
            loadingIndicator.frame.origin.x = 0
            let animationDuration: TimeInterval = 1.0
            let loadingBarWidth = loadingBar.frame.width - loadingIndicator.frame.width
        
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.loadingIndicator.frame.origin.x = loadingBarWidth
            }, completion: nil)
    }
}
