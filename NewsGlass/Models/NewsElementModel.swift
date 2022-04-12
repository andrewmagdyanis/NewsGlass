import Foundation

class NewsElementModel: Codable, Identifiable {
    let uri: String
    let url: String
    let id, assetID: Int
    let source: String
    let publishedDateString: String
    let updatedString: String
    let section, subsection: String
    let nytdsection, adxKeywords: String
    let column: JSONNull?
    let byline: String
    let type: ResultType
    let title, abstract: String
    let desFacet, orgFacet, perFacet, geoFacet: [String]
    let media: [Media]
    let etaID: Int

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDateString = "published_date"
        case updatedString = "updated"
        case section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    public var updated: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.date(from: updatedString)!
        }
    }

    public var publishedDate: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: publishedDateString)!
        }
    }
    
    init(uri: String, url: String, id: Int, assetID: Int, source: String, publishedDateString: String, updatedString: String, section: String, subsection: String, nytdsection: String, adxKeywords: String, column: JSONNull?, byline: String, type: ResultType, title: String, abstract: String, desFacet: [String], orgFacet: [String], perFacet: [String], geoFacet: [String], media: [Media], etaID: Int) {

        self.publishedDateString = publishedDateString
        self.updatedString = updatedString
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
}


enum Subtype: String, Codable {
    case photo = "photo"
}


enum ResultType: String, Codable {
    case article = "Article"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
