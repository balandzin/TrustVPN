import UIKit

final class ConnectionToViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var closeButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.closeButton) ?? UIImage(named: "closeButton")
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        button.addGestureRecognizer(recognizer)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var connectionToLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.text = AppText.connectionTo
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var loadingBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dataSecurityLabel
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var  loadingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingIndicator
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startAnimation()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(containerView)
        containerView.addSubview(closeButton)
        containerView.addSubview(connectionToLabel)
        containerView.addSubview(countryName)
        containerView.addSubview(loadingBar)
        loadingBar.addSubview(loadingIndicator)
        
        setupConstraints()
    }
    
    func setupView(server: VpnServers) {
        countryName.text = server.countryName
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: false) { [weak self] in
            self?.view.layer.removeAllAnimations()
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

// MARK: - Constraints
extension ConnectionToViewController {
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(115)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        connectionToLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(109)
        }
        
        countryName.snp.makeConstraints { make in
            make.bottom.equalTo(connectionToLabel.snp.bottom)
            make.leading.equalTo(connectionToLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        
        loadingBar.snp.makeConstraints { make in
            make.top.equalTo(connectionToLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(54)
            make.height.equalTo(6)
        }
    }
}
