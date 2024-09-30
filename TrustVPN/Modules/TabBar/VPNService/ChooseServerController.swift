import UIKit

class ChooseServerController: UITableViewController {

    // MARK: - GUI Variables
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        
    }
    
    
    // MARK: - ObjC Methods
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
