import UIKit

final class ServerСell: UITableViewCell {
    
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.almostWhite
        view.layer.cornerRadius = 19
        return view
    }()
    
    private lazy var dropView: UIView = {
        let image = UIView()
        image.backgroundColor = AppColors.dropRed
        image.layer.cornerRadius = 4
        return image
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Disconnected"
        label.textAlignment = .left
        label.textColor = AppColors.termsView
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var serverName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.text = "Server Fx-01y29x "
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "deleteIMG")
        return image
    }()
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.text = "Netherlands"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var dots: UIImageView = {
        let image = TouchableImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.dots) ?? UIImage(named: "dots")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dotsButtonTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        return image
    }()
    
    private lazy var swipeConnectView: SwipeConnectView = {
        let view = SwipeConnectView(type: .off)
        view.layer.cornerRadius = 36
        view.backgroundColor = AppColors.swipeBackground
        return view
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dotsButtonTapped() {
        print("dotsButtonTapped")
    }
    
    // MARK: - Private Methods
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(statusView)
        statusView.addSubview(dropView)
        statusView.addSubview(statusLabel)
        containerView.addSubview(serverName)
        containerView.addSubview(flagImage)
        containerView.addSubview(countryName)
        contentView.addSubview(dots)
        contentView.addSubview(swipeConnectView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(280)
        }
        
        statusView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.height.equalTo(38)
            make.width.equalTo(118)
        }
        
        dropView.snp.makeConstraints { make in
            make.leading.equalTo(statusView).offset(10)
            make.centerY.equalTo(statusView)
            make.width.height.equalTo(8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(dropView.snp.trailing).offset(10)
            make.centerY.equalTo(dropView)
            make.trailing.equalTo(statusView).inset(5)
        }
        
        dots.snp.makeConstraints { make in
            make.centerY.equalTo(statusView)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        serverName.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        flagImage.snp.makeConstraints { make in
            make.top.equalTo(serverName.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.width.height.equalTo(40)
        }
        
        countryName.snp.makeConstraints { make in
            make.centerY.equalTo(flagImage)
            make.leading.equalTo(flagImage.snp.trailing).offset(10)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        swipeConnectView.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.bottom.equalTo(containerView).inset(20)
            make.width.equalTo(287)
            make.height.equalTo(72)
        }
        
        
    }
}

class TouchableImageView: UIImageView {
    var touchableArea: CGSize = CGSize(width: 40, height: 40)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerArea = CGRect(
            x: bounds.origin.x - (touchableArea.width - bounds.width) / 2,
            y: bounds.origin.y - (touchableArea.height - bounds.height) / 2,
            width: bounds.width + touchableArea.width,
            height: bounds.height + touchableArea.height
        )
        return largerArea.contains(point)
    }
}
