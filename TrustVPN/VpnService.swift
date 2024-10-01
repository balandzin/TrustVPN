import Foundation
import AVVPNService
import NetworkExtension

final class VpnService {
    
    enum State {
        case disconnected
    }
    
    var state: State = .disconnected
    var stateConnect: ((NEVPNStatus) -> Void)?
    var stateNewConnect: ((NEVPNStatus) -> Void)?
    
    func connect(credentials: AVVPNCredentials?, complition: @escaping () -> Void, complitionError: @escaping () -> Void) {
        guard state == .disconnected else { return }
        AVVPNService.shared.connect(credentials: credentials) {  [weak self] error in
            guard let self = self else { return }
                        
            self.stateNewConnect = { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .connected:
                    complition()
                case .disconnected:
                    complitionError()
                    self.state = .disconnected
                default:
                    break
                }
            }
        }
    }
    
    func disconnectToVPN() {
        AVVPNService.shared.disconnect()
    }
    
    func vpnStartDelegate() {
        AVVPNService.shared.delegate = self
    }
}

extension VpnService: AVVPNServiceDelegate {
    
    func vpnService(_ service: AVVPNService, didChange status: NEVPNStatus) {
        stateConnect?(status)
        stateNewConnect?(status)
    }
}
