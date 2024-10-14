import UIKit

final class Default {
    
    enum KeyId: String {
        case isShowOnboard
        case isShowDeviceSearchInfo
        case linkItems
        case countScan
        case wifiScan
        case vpnIndex
        case dailyLimitSecond
        case statistic
        case isConnectVpn
        case isFirstShowAverageTime
    }
    
    static let maxTimeLimit = 10800
    
    static let shared = Default()
    
    static var startDateConnectVpn: Date {
        get {
            return UserDefaults.standard.date(forKey: "startDateConnectVpn") ?? Date()
        } set {
            UserDefaults.standard.set(date: newValue, forKey: "startDateConnectVpn")
        }
    }
    
    static var hasLoggedInToday: Date? {
        get {
            return UserDefaults.standard.date(forKey: "hasLoggedInToday") ?? nil
        }
        set {
            UserDefaults.standard.set(date: newValue, forKey: "hasLoggedInToday")
        }
    }
    
    var statistic: [StatisticInfo] {
        get { userDefaults?.getObjectNew(key: KeyId.statistic.rawValue, type: []) ?? [] }
        set { userDefaults?.setObjectNew(newValue, key: KeyId.statistic.rawValue)}
    }
    
    var linkItems: [LinkVault] {
        get { userDefaults?.getObjectNew(key: KeyId.linkItems.rawValue, type: []) ?? [] }
        set { userDefaults?.setObjectNew(newValue, key: KeyId.linkItems.rawValue)}
    }
    
    var wifiScan: [WifiScanResult] {
        get { userDefaults?.getObjectNew(key: KeyId.wifiScan.rawValue, type: []) ?? [] }
        set { userDefaults?.setObjectNew(newValue, key: KeyId.wifiScan.rawValue)}
    }
    
    var isFirstShowAverageTime: [Int] {
        get { getFlag(.isFirstShowAverageTime ) as? [Int] ?? [] }
        set { setFlag(newValue, key: .isFirstShowAverageTime) }
    }
    
    var isConnectVpn: Bool {
        get { getFlag(.isConnectVpn ) as? Bool ?? false }
        set { setFlag(newValue, key: .isConnectVpn) }
    }
    
    var dailyLimitSecond: Int {
        get { getFlag(.dailyLimitSecond) as? Int ?? Default.maxTimeLimit }
        set { setFlag(newValue, key: .dailyLimitSecond) }
    }
    
    var countScan: Int {
        get { getFlag(.countScan) as? Int ?? 3 }
        set { setFlag(newValue, key: .countScan) }
    }
    
    var vpnIndex: Int {
        get { getFlag(.vpnIndex) as? Int ?? 0 }
        set { setFlag(newValue, key: .vpnIndex) }
    }
    
    var isShowOnboard: Bool {
        get { getFlag(.isShowOnboard) as? Bool ?? false }
        set { setFlag(newValue, key: .isShowOnboard) }
    }
    
    var isShowDeviceSearchInfo: Bool {
        get { getFlag(.isShowDeviceSearchInfo) as? Bool ?? false }
        set { setFlag(newValue, key: .isShowDeviceSearchInfo) }
    }
    
    private lazy var userDefaults = UserDefaults(suiteName: "application")
    
    private func setFlag(_ value: Any, key: KeyId) {
        userDefaults?.set(value, forKey: key.rawValue)
        userDefaults?.synchronize()
    }
    
    private func getFlag(_ key: KeyId) -> Any? {
        return userDefaults?.value(forKey: key.rawValue)
    }
}

struct LinkVault: Codable {
    var id: String = UUID().uuidString
    var date: Date = Date()
    var url: String = ""
    var name: String = ""
    var isAutomatic: Bool = false
    
    init() {
    }
}

struct StatisticInfo: Codable {
    var second: Int
    var date: Date
    var vpn: StatisticVpnInfo
}

struct StatisticVpnInfo: Codable {
    var name: String
    var imageUrl: String
}

struct WifiScanResult: Codable {
    var nameRouter: String
    var items: [WifiScanModel]
}

struct WifiScanModel: Codable {
    var brand: String
    var hostname: String
    var ipAddress: String
    var isLocalDevice: Bool
    var macAddress: String
    var subnetMask: String
}

enum StatusWifiScan: UInt32 {
    case finish = 0
    case cancel = 1
}
