import Foundation

class Media: Codable, Identifiable {
    let type: MediaType
    let subtype: String
    let caption, copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }

    init(type: MediaType, subtype: String, caption: String, copyright: String, approvedForSyndication: Int, mediaMetadata: [MediaMetadatum]) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}

enum MediaType: String, Codable {
    case image = "image"
}
