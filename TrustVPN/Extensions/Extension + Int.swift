import Foundation
import UIKit

extension Int {
    
    var horizontal: CGFloat {
        return (CGFloat(self) / 375) * UIScreen.width
    }
    
    var vertical: CGFloat {
        return (CGFloat(self) / 812) * UIScreen.height
    }
    
    var timeString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var timeStatString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        return hours == 0 ? String(format: "%02d:%02d", minutes, seconds) : String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension CGFloat {
    
    var horizontal: CGFloat {
        return (self / 375) * UIScreen.width
    }
    
    var vertical: CGFloat {
        return (self / 812) * UIScreen.height
    }
}

extension Double {
    
    var horizontal: Double {
        return (self / 375) * UIScreen.width
    }
    
    var vertical: Double {
        return (self / 812) * UIScreen.height
    }
}

extension UIScreen {
    static var width: CGFloat { UIScreen.main.bounds.width }
    static var height: CGFloat { UIScreen.main.bounds.height }
}
