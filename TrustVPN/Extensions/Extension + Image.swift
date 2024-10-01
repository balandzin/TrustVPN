import Foundation
import Kingfisher
import UIKit

extension UIImage {
    
        static func loadImage(_ urlString: String?) -> UIImage {
            let image = UIImageView()
            guard let url = URL(string: urlString ?? "") else { return UIImage() }
            
            
            image.kf.setImage(with: url, options: [.transition(.fade(0)), .cacheOriginalImage, .loadDiskFileSynchronously]) { result, error in
                image.image = image.image
            }

            return image.image ?? UIImage()
        }
    
//    static func loadImage(_ urlString: String?) -> UIImage? {
//        guard let urlString = urlString, let url = URL(string: urlString) else {
//            return nil
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            return UIImage(data: data)
//        } catch {
//            print("Ошибка загрузки изображения: \(error)")
//            return nil
//        }
//    }
}
