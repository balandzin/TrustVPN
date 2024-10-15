import UIKit

final class DropdownCell: UITableViewCell {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(text: String) {
        descriptionLabel.text = text
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(descriptionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
