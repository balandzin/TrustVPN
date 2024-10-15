import UIKit

final class  CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - GUI Variables
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostWhite
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    static let identifier = "CustomCollectionViewCell"
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with model: CollectionItemModel) {
            iconImageView.image = model.icon
            titleLabel.text = model.title
        }
    
    // MARK: - Private Methods
    private func setupStyle() {
        contentView.backgroundColor = AppColors.termsView
        contentView.layer.cornerRadius = 26
        contentView.layer.masksToBounds = true
    }
    
    private func setupView() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
}
