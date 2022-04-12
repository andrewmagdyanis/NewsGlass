import Foundation

class NewsResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [NewsElementModel]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String, copyright: String, numResults: Int, results: [NewsElementModel]) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}

