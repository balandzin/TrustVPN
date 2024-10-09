import UIKit

final class ServerСell: UITableViewCell {
    
    // MARK: - GUI Variables
    let popupView = PopupView()
    
    lazy var serverName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var swipeConnectView: SwipeConnectView = {
        let view = SwipeConnectView(type: .off)
        view.layer.cornerRadius = 36
        view.backgroundColor = AppColors.swipeBackground
        return view
    }()
    
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
        label.text = AppText.disconnected
        label.textAlignment = .left
        label.textColor = AppColors.termsView
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
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
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        addDismissGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dotsButtonTapped() {
        popupView.isHidden.toggle()
    }
    
    private func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissPopup(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: contentView)
        if !popupView.frame.contains(touchLocation) {
            popupView.isHidden = true
        }
    }
    
    // MARK: - Methods
    func updateCell(model: VpnServers, isConnect: Bool) {
        flagImage.image = .loadImage(model.countryImageMin) ?? UIImage(named: "deleteIMG")
        countryName.text = model.countryName
        serverName.text = model.serverName
        
        if isConnect {
            statusLabel.text = AppText.connected
            dropView.backgroundColor = AppColors.loadingIndicator
        } else {
            statusLabel.text = AppText.disconnected
            dropView.backgroundColor = AppColors.dropRed
        }
    }
    
    // MARK: - Private Methods
    func setupCell() {
        
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
        containerView.addSubview(popupView)
        contentView.addSubview(swipeConnectView)
        popupView.isHidden = true
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
            make.width.equalTo(125)
        }
        
        dropView.snp.makeConstraints { make in
            make.leading.equalTo(statusView).offset(10)
            make.centerY.equalTo(statusView)
            make.width.height.equalTo(8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(dropView.snp.trailing).offset(5)
            make.centerY.equalTo(dropView)
            make.trailing.equalTo(statusView).inset(10)
        }
        
        dots.snp.makeConstraints { make in
            make.centerY.equalTo(statusView)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(dots.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
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
