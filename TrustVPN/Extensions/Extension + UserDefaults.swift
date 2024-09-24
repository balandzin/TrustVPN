import Foundation

extension UserDefaults {
    
    func getObjectNew<T: Decodable>(key: String, type: T) -> T? {
        guard let decoded  = data(forKey: key) else{return nil}
        return try? JSONDecoder().decode(T.self, from: decoded)
    }

    func setObjectNew<T: Encodable>(_ data: T, key: String) {
        if let object = try? JSONEncoder().encode(data) {
            set(object, forKey: key)
        }
    }
    
    func set(date: Date?, forKey key: String){
        self.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }
}
