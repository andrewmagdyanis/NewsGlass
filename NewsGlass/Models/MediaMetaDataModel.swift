import Foundation

class MediaMetadatum: Codable {
    let url: String
    let format: Format
    let height, width: Int

    init(url: String, format: Format, height: Int, width: Int) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}
