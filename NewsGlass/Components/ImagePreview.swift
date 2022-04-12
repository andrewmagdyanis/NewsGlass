import Foundation
import SwiftUI

struct ImagePreview: View {
    var mediaImage: MediaMetadatum
    var timeSincePublishedDate: TimeSinceDate
    var timeSinceUpdatedDate: TimeSinceDate
    var underImageTextColor: Color

    init(mediaImage: MediaMetadatum, timeSincePublishedDate: TimeSinceDate, timeSinceUpdatedDate: TimeSinceDate, underImageTextColor: Color) {
        self.mediaImage = mediaImage
        
        self.timeSincePublishedDate = timeSincePublishedDate
    
        self.timeSinceUpdatedDate = timeSinceUpdatedDate
        
        self.underImageTextColor = underImageTextColor
    }
    
    var body: some View {
                AsyncImage(url: URL(string: mediaImage.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(width: UIScreen.main.bounds.size.width - 30, height: CGFloat(mediaImage.height))
                    case .success(let image):
                        VStack {
                            image.resizable().scaledToFill().frame(width: CGFloat(mediaImage.width), height: CGFloat(mediaImage.height)).clipped()

                            Text(timeSincePublishedDate.timeString).frame(width: UIScreen.main.bounds.size.width, alignment: .leading).padding(.leading, CGFloat(20)).foregroundColor(underImageTextColor)

                            Text("last updated " + timeSinceUpdatedDate.timeString).frame(width: UIScreen.main.bounds.size.width, alignment: .leading).padding(.leading, CGFloat(20)).foregroundColor(underImageTextColor)
                        }.padding(.bottom, CGFloat(10)).frame(width: UIScreen.main.bounds.size.width-30).padding(.leading, CGFloat(10))
                    
                    case .failure(_):
                        Text("error")
                    @unknown default:
                        fatalError()
                    }
                }
    }
}
