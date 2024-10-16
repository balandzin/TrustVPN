import UIKit

import UIKit

final class DropdownTableView: UITableView {
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
        register(DropdownCell.self, forCellReuseIdentifier: "DropdownCell")
        register(DropdownHeaderCell.self, forCellReuseIdentifier: "DropdownHeaderCell")
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        separatorStyle = .none
    }
}

