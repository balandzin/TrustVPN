import UIKit
import SnapKit

final class PopupView: UIView {
    
    // MARK: - GUI Variables
    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.swipeBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dataSecurityLabel
        return view
    }()
    
    var renameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.renameServer, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.removeServer, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(popupView)
        popupView.addSubview(renameButton)
        popupView.addSubview(separatorView)
        popupView.addSubview(removeButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        popupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(145)
        }
        
        renameButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(30)
        }
        
        separatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(144)
            make.height.equalTo(1)
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
