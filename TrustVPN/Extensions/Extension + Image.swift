import Foundation
import Kingfisher
import UIKit

extension UIImage {
// ЗДЕСЬ ВОЗНИКАЕТ ОШИБКА
//        static func loadImage(_ urlString: String?) -> UIImage {
//            let image = UIImageView()
//            guard let url = URL(string: urlString ?? "") else { return UIImage() }
//            
//            
//            image.kf.setImage(with: url, options: [.transition(.fade(0)), .cacheOriginalImage, .loadDiskFileSynchronously]) { result, error in
//                image.image = image.image
//            }
//
//            return image.image ?? UIImage()
//        }
 
    
// ЭТОТ МТОД РАБОЧИЙ
    static func loadImage(_ urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            completion(nil) // Возвращаем nil, если URL невалиден
            return
        }
        
        // Создаем временный UIImageView для загрузки изображения
        let imageView = UIImageView()
        
        // Выполняем загрузку на главном потоке
        DispatchQueue.main.async {
            imageView.kf.setImage(with: url) { result in
                switch result {
                case .success(let value):
                    completion(value.image) // Успех: возвращаем изображение
                case .failure:
                    completion(nil) // Ошибка: возвращаем nil
                }
            }
        }
    }
    
    static func loadImage(_ urlString: String?) -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("Ошибка загрузки изображения: \(error)")
            return nil
        }
    }
}




