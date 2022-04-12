import Foundation
import SwiftUI

struct NewsComponent: View {
    var newsElement: NewsElementModel
    var timeSincePublishedDate: TimeSinceDate
    var timeSinceUpdatedDate: TimeSinceDate

    init(newsElement: NewsElementModel) {
        self.newsElement = newsElement
        
        self.timeSincePublishedDate = TimeSinceDate(timeInterval: Date.now.timeIntervalSince(newsElement.publishedDate))
    
        self.timeSinceUpdatedDate = TimeSinceDate(timeInterval: Date.now.timeIntervalSince(newsElement.updated))
    }
    
    var body: some View {
        ZStack {
            Constants.Colors.basicButtonBackgroundColor

            VStack (alignment: .leading, spacing: 2) {
                HStack {
                    Text(newsElement.source).font(.subheadline).bold().foregroundColor(Constants.Colors.mainBackgroundColor)
                    
                    Spacer()
                    
                    Text(newsElement.section + " " + newsElement.subsection).font(.subheadline).bold().foregroundColor(Color.red)
                
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)).frame(alignment: .leading)

                Divider()
                
                HStack {
                    Text(newsElement.title).font(.title2).bold().foregroundColor(Color.black).multilineTextAlignment(.leading).frame(alignment: .leading)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).frame(alignment: .leading)
                          
                if newsElement.media.count > 0 {
                    ForEach(newsElement.media) { m in
                        if m.mediaMetadata.count > 0 {
                            let mediaImage: MediaMetadatum = m.mediaMetadata[m.mediaMetadata.count-1]
                            ImagePreview(mediaImage: mediaImage, timeSincePublishedDate: timeSincePublishedDate, timeSinceUpdatedDate: timeSinceUpdatedDate, underImageTextColor: Color.black)
                        }
                    }
                }
            }.frame(width: UIScreen.main.bounds.size.width - 30, alignment: .center).scaledToFit().aspectRatio(contentMode: .fit)
        }.cornerRadius(15)

    }
}
