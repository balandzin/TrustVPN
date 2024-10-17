import UIKit

class BottomSheetController: UIViewController {
    
    lazy var bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate(
        preferredSheetTopInset: preferredSheetTopInset,
        preferredSheetCornerRadius: preferredSheetCornerRadius,
        preferredSheetSizingFactor: preferredSheetSizing,
        preferredSheetBackdropColor: preferredSheetBackdropColor
    )
    
    var closeSwipe: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheetTransitioningDelegate.closeSwipe = { [weak self] in
            guard let self = self else { return }
            self.closeSwipe?()
        }
    }
    
    override var additionalSafeAreaInsets: UIEdgeInsets {
        get {
            .init(
                top: super.additionalSafeAreaInsets.top + preferredSheetCornerRadius,
                left: super.additionalSafeAreaInsets.left,
                bottom: super.additionalSafeAreaInsets.bottom,
                right: super.additionalSafeAreaInsets.right
            )
        }
        set {
            super.additionalSafeAreaInsets = newValue
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            .custom
        }
        set {
        }
    }
    
    override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            bottomSheetTransitioningDelegate
        }
        set {
            
        }
    }
    
    var preferredSheetTopInset: CGFloat = 0 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetTopInset = preferredSheetTopInset
        }
    }
    
    var preferredSheetCornerRadius: CGFloat = 0 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetCornerRadius = preferredSheetCornerRadius
        }
    }
    
    var preferredSheetSizing: CGFloat = 100 {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetSizingFactor = preferredSheetSizing
        }
    }
    
    var preferredSheetBackdropColor: UIColor = .init(hex: "000000", alpha: 0.4) {
        didSet {
            bottomSheetTransitioningDelegate.preferredSheetBackdropColor = preferredSheetBackdropColor
        }
    }
    
    var tapToDismissEnabled: Bool = true {
        didSet {
            bottomSheetTransitioningDelegate.tapToDismissEnabled = tapToDismissEnabled
        }
    }
    
    var panToDismissEnabled: Bool = true {
        didSet {
            bottomSheetTransitioningDelegate.panToDismissEnabled = panToDismissEnabled
        }
    }
}
