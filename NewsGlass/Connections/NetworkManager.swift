import Foundation
import Moya

// Protocol (interface of the class)
protocol Networkable {
    var provider: MoyaProvider<NewsAPI> { get }
    
    func fetchPopularViewedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ())
    func fetchPopularEmailedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ())
    func fetchPopularSharedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ())
}

// NetworkManager class that conforms to the Networkable Protocol
class NetworkManager: Networkable, ObservableObject {
    var provider = MoyaProvider<NewsAPI>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPopularViewedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ()) {
        request(target: .viewed(period: period), completion: completion)
    }
    func fetchPopularEmailedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ()) {
        request(target: .emailed(period: period), completion: completion)
    }
    func fetchPopularSharedNews(period: Int, completion: @escaping (Result<NewsResponse, Error>) -> ()) {
        request(target: .shared(period: period), completion: completion)
    }
}

// MARK: Make the request in the extension
private extension NetworkManager {
    private func request<T: Decodable>(target: NewsAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
            do {
                let results = try JSONDecoder().decode(T.self, from: response.data)
                completion(.success(results))
            } catch let error {
                completion(.failure(error))
            }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
