import Foundation

class NetworkInfoFetcher {
    
    static let shared = NetworkInfoFetcher()
    
    private let apiUrl = "https://ipinfo.io/json"
    
    func fetchConnectionInfo(completion: @escaping (Result<ConnectionInfo, Error>) -> Void) {
        guard let url = URL(string: apiUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let connectionInfo = try JSONDecoder().decode(ConnectionInfo.self, from: data)
                completion(.success(connectionInfo))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        
        task.resume()
    }
}
