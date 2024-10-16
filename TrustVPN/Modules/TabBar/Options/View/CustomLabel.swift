import UIKit
import SnapKit

final class CustomLabel: UILabel {

    // MARK: - Initialization
    init(title: String = "", fontSize: CGFloat = 18, textColor: UIColor = AppColors.almostWhite, textAlignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.text = title
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    // MARK: - Private Methods
    private func setupStyle() {
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
    }
    
    func setupConstraints(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().offset(-7)
        }
    }
}
