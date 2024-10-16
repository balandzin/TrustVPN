import UIKit

struct CollectionItemModel {
    let icon: UIImage
    let title: String
    let destinationVC: UIViewController
}

struct ConnectionInfo: Decodable {
    let ip: String
    let hostname: String?
    let city: String?
    let region: String?
    let country: String?
    let loc: String?
    let org: String?
    let postal: String?
    let timezone: String
    let asn: ASNInfo?
}

struct ASNInfo: Decodable {
    let asn: String
    let name: String
    let domain: String?
    let route: String?
    let type: String?
}
