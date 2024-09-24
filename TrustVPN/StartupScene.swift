import UIKit
import SnapKit

final class StartupScene: UIViewController {
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
        view.backgroundColor = Colors.loadingBar
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var  loadingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.loadingIndicator
        view.layer.cornerRadius = 3
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
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
        // Установите начальную позицию индикатора загрузки
            loadingIndicator.frame.origin.x = 0
            
            // Анимация перемещения индикатора загрузки
            let animationDuration: TimeInterval = 1.0
            let loadingBarWidth = loadingBar.frame.width - loadingIndicator.frame.width // Вычитаем ширину индикатора
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.autoreverse, .repeat], animations: {
                // Двигаем индикатор загрузки вправо
                self.loadingIndicator.frame.origin.x = loadingBarWidth
            }, completion: nil)
    }
    
}

