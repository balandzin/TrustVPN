import SnapKit
import UIKit

final class OnboardScene: UIViewController {
    // MARK: - GUI Variables
    
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


