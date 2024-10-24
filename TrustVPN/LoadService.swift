//import Kingfisher
import UIKit

final class LoadService {
    
    static var shared = LoadService()
    
    var load: ConfigureModel? = nil
    
    private var counting = 0
    
    func get(_ completion: @escaping ((ConfigureModel) -> Void), errorCompletion: @escaping (() -> Void)) {
        let sdjkfjksd = "aHR0cHM6Ly9h"
        let kjgfshkj = "cHBzdnBuc2Vy"
        let vcxbmn = "dmVyLmM="
        let erguty = "b20vc3A="
        let kjnqw = "eWd1YXJkdnA="
        let dsvldksjf = "bnBybz9sYW49"
        let xnfgkljs = String(Locale.preferredLanguages[0].prefix(2))
        
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: sdjkfjksd.decodeUTF8() +
                                kjgfshkj.decodeUTF8() +
                                vcxbmn.decodeUTF8() +
                                erguty.decodeUTF8() +
                                kjnqw.decodeUTF8() +
                                dsvldksjf.decodeUTF8() +
                                xnfgkljs) else { return }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 300
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        errorCompletion()
                    }
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        errorCompletion()
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let model = try decoder.decode(ConfigureModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        // Установка цветов из модели
                        AppColors.loadingBar = .init(hex: model.colors?.loadingBar ?? "#303030")
                        AppColors.loadingIndicator = .init(hex: model.colors?.loadingIndicator ?? "#0093E5")
                        AppColors.dataSecurityLabel = .init(hex: model.colors?.dataSecurityLabel ?? "#A0A0A0")
                        AppColors.termsView = .init(hex: model.colors?.termsView ?? "#262626")
                        AppColors.almostWhite = .init(hex: model.colors?.almostWhite ?? "#FAFAFA")
                        AppColors.dropRed = .init(hex: model.colors?.dropRed ?? "#D52B1E")
                        AppColors.textFieldBackground = .init(hex: model.colors?.textFieldBackground ?? "#3A3A3A")
                        AppColors.unsecurePassword = .init(hex: model.colors?.unsecurePassword ?? "#F53333")
                        AppColors.mediumPassword = .init(hex: model.colors?.mediumPassword ?? "#E7EB14")
                        AppColors.strongPassword = .init(hex: model.colors?.strongPassword ?? "#2ECC71")
                        AppColors.lightBlueAccent1 = .init(hex: model.colors?.lightBlueAccent1 ?? "#8DF2FA")
                        AppColors.mediumBlueAccent2 = .init(hex: model.colors?.mediumBlueAccent2 ?? "#44C0E3")
                        AppColors.darkBlueAccent3 = .init(hex: model.colors?.darkBlueAccent3 ?? "#119EE3")
                        AppColors.primary = .init(hex: model.colors?.primary ?? "#181818")
                        
                        // Инициализация массива URL изображений
                        var imagesUrl = [String]()
                        
                        // Добавление изображений из модели
                        if let images = model.images {
                            let mirror = Mirror(reflecting: images)
                            for child in mirror.children {
                                if let stringValue = child.value as? String {
                                    imagesUrl.append(stringValue)
                                }
                            }
                        }
                        
                        model.vpnServers?.forEach { server in
                            if let countryImageMax = server.countryImageMax {
                                imagesUrl.append(countryImageMax)
                            }
                            if let countryImageMin = server.countryImageMin {
                                imagesUrl.append(countryImageMin)
                            }
                        }
                        
                        // Загрузка изображений
                        self.counting = 0
                        let totalImages = imagesUrl.count
                        
                        for urlString in imagesUrl {
                            guard let urlImage = URL(string: urlString) else { continue }
                            
                            KingfisherManager.shared.retrieveImage(with: urlImage, options: [.cacheOriginalImage, .loadDiskFileSynchronously]) { result in
                                self.counting += 1
                                
                                switch result {
                                case .success(let value):
                                    print("Loaded image: \(value.source.url?.absoluteString ?? "unknown")")
                                case .failure(let error):
                                    print("Error loading image: \(error.localizedDescription)")
                                }
                                
                                if self.counting == totalImages {
                                    DispatchQueue.main.async {
                                        completion(model)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        errorCompletion()
                    }
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
