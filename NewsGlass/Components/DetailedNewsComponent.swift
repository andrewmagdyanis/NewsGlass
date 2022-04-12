import Foundation
import SwiftUI

struct DetailedNewsComponent: View {
    var newsElement: NewsElementModel
    var timeSincePublishedDate: TimeSinceDate
    var timeSinceUpdatedDate: TimeSinceDate

    init(newsElement: NewsElementModel) {
        self.newsElement = newsElement
        
        self.timeSincePublishedDate = TimeSinceDate(timeInterval: Date.now.timeIntervalSince(newsElement.publishedDate))
    
        self.timeSinceUpdatedDate = TimeSinceDate(timeInterval: Date.now.timeIntervalSince(newsElement.updated))
    }
    
    var body: some View {
        ScrollView {
          VStack (alignment: .leading, spacing: 2) {
                HStack {
                    Text(newsElement.source).font(.subheadline).bold().foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text(newsElement.type).font(.subheadline).bold().foregroundColor(Color.orange)
                
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)).frame(alignment: .leading)

                VStack {
                    Text(newsElement.title).font(.title2).bold().foregroundColor(Color.white).multilineTextAlignment(.leading).frame(alignment: .leading)
                    Text(newsElement.abstract)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).frame(alignment: .leading)
              
                if newsElement.media.count > 0 {
                    ForEach(newsElement.media) { m in
                        if m.mediaMetadata.count > 0 {
                            let mediaImage: MediaMetadatum = m.mediaMetadata[m.mediaMetadata.count-1]
                            ImagePreview(mediaImage: mediaImage, timeSincePublishedDate: timeSincePublishedDate, timeSinceUpdatedDate: timeSinceUpdatedDate, underImageTextColor: Color.white)
                        }
                    }
                }
          }.padding(.top, 60)
        }.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center).scaledToFit().aspectRatio(contentMode: .fit)
}
}
