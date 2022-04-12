import Foundation
import SwiftUI

struct ImagePreview: View {
    var mediaImage: MediaMetadatum
    var timeSincePublishedDate: TimeSinceDate
    var timeSinceUpdatedDate: TimeSinceDate

    init(mediaImage: MediaMetadatum, timeSincePublishedDate: TimeSinceDate, timeSinceUpdatedDate: TimeSinceDate ) {
        self.mediaImage = mediaImage
        
        self.timeSincePublishedDate = timeSincePublishedDate
    
        self.timeSinceUpdatedDate = timeSinceUpdatedDate
    }
    
    var body: some View {
                AsyncImage(url: URL(string: mediaImage.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(width: UIScreen.main.bounds.size.width - 30, height: CGFloat(mediaImage.height))
                    case .success(let image):
                        VStack {
                            image.resizable().scaledToFill().frame(width: CGFloat(mediaImage.width), height: CGFloat(mediaImage.height)).clipped()

                            Text(timeSincePublishedDate.timeString).frame(width: UIScreen.main.bounds.size.width, alignment: .leading).padding(.leading, CGFloat(10)).foregroundColor(Color.white)

                            Text("last updated " + timeSinceUpdatedDate.timeString).frame(width: UIScreen.main.bounds.size.width, alignment: .leading).padding(.leading, CGFloat(10)).foregroundColor(Color.white)
                        }.padding(.bottom, CGFloat(10)).frame(width: UIScreen.main.bounds.size.width-30).padding(.leading, CGFloat(10))
                    
                    case .failure(_):
                        Text("error")
                    @unknown default:
                        fatalError()
                    }
                }
    }
}
