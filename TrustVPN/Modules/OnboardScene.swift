import SnapKit
import UIKit

final class OnboardScene: UIViewController {
    
    // MARK: - GUI Variables
    private let imageStack = UIStackView(ax: .horizontal, alignm: .center, distr: .fill)
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "onboardImage")
        return image
    }()
    
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
    }
}


