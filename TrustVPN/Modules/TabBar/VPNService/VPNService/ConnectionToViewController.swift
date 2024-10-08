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
        label.textAlignment = .center
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = AppText.connectionTo
        return label
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
        containerView.addSubview(countryStackView)
        countryStackView.addArrangedSubview(flagImage)
        countryStackView.addArrangedSubview(countryName)
        containerView.addSubview(loadingBar)
        loadingBar.addSubview(loadingIndicator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(210)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        connectionToLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        countryStackView.snp.makeConstraints { make in
            make.top.equalTo(connectionToLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        flagImage.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        loadingBar.snp.makeConstraints { make in
            make.top.equalTo(countryStackView.snp.bottom).offset(30)
            make.width.equalTo(110)
            make.height.equalTo(6)
            make.centerX.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(6)
        }
    }
    
    
    func setupView(server: VpnServers) {
        countryName.text = server.countryName
        flagImage.image = .loadImage(server.countryImageMin) ?? UIImage(named: "deleteIMG")
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
