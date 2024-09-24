import Foundation
import UIKit

extension UIImage {
    
//    static func loadImage(_ urlString: String?) -> UIImage {
//        let image = UIImageView()
//        guard let url = URL(string: urlString ?? "") else { return UIImage() }
//        image.kf.setImage(with: url, options: [.transition(.fade(0)), .cacheOriginalImage, .loadDiskFileSynchronously]) { result, error in
//            image.image = image.image
//        }
//        return image.image ?? UIImage()
//    }
    
    static func loadImage(_ urlString: String?, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString ?? "") else {
                // Если URL некорректен, возвращаем nil
                completion(nil)
                return
            }

            let imageView = UIImageView()
            
            // Переход на главный поток для выполнения метода setImage
            DispatchQueue.main.async {
                imageView.kf.setImage(with: url, options: [.transition(.fade(0)), .cacheOriginalImage, .loadDiskFileSynchronously]) { result in
                    switch result {
                    case .success(let value):
                        // Возвращаем загруженное изображение через completion
                        completion(value.image)
                    case .failure(_):
                        // В случае ошибки, возвращаем nil
                        completion(nil)
                    }
                }
            }
        }
}
