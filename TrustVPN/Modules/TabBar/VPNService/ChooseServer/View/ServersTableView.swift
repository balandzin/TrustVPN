import UIKit

final class ServersTableView: UITableView {
    
    // MARK: - Initialization
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        register(ChooseServerСell.self, forCellReuseIdentifier: "ChooseServerСell")
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        separatorStyle = .none
    }
}
