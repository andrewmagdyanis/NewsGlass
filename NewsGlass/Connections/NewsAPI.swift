import Foundation
import Moya

enum NewsAPI {
    case emailed(period: Int)
    case shared(period: Int)
    case viewed(period: Int)
}

// MARK: - TargetType Protocol Implementation
extension NewsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")
        else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .emailed(let period):
            return "emailed/\(period).json"
        case .shared(let period):
            return "shared/\(period).json"
        case .viewed(let period):
            return "viewed/\(period).json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailed(_), .shared(_), .viewed(_):
            return .get
        }
    }
        
    var task: Task {
        switch self {
        case .emailed(_), .shared(_), .viewed(_):
            return .requestParameters(parameters: ["api-key" : Constants.API.apiKey], encoding: URLEncoding.queryString)
        }
    }
        
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
