import UIKit

final class InfoView: UIView {
    
    private let stackView = UIStackView(ax: .vertical, alignm: .fill, distr: .fill)
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 24.vertical, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16.vertical, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func info(title: String, subTitle: String) {
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    private func setupUI() {
        stackView.spacing = 12.vertical
        stackView.isUserInteractionEnabled = false
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        
        stackView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subTitle)
    }
}
