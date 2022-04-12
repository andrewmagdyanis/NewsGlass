import Foundation
import SwiftUI

struct NewsHomePage: View {
    @EnvironmentObject var networkManager: NetworkManager
    @State var newsList: [NewsElementModel] = []
    @State var newsCount: Int = 0
    @State var apiType: NewsAPI
    
    init(apiType: NewsAPI) {
        self.apiType = apiType
    }
    
    func onAppear() {
    
        switch apiType {
        case .emailed(let period):
            self.networkManager.fetchPopularEmailedNews(period: period) { result in
                switch result {
                case .success(let newsResponse):
                    self.newsCount = newsResponse.numResults
                    self.newsList = newsResponse.results
                    break
                case .failure(_):
                    print("error")
                    break
                }
            }
        case .shared(let period):
            self.networkManager.fetchPopularSharedNews(period: period) { result in
                switch result {
                case .success(let newsResponse):
                    self.newsCount = newsResponse.numResults
                    self.newsList = newsResponse.results
                    break
                case .failure(_):
                    print("error")
                    break
                }
            }
        case .viewed(let period):
            self.networkManager.fetchPopularViewedNews(period: period) { result in
                switch result {
                case .success(let newsResponse):
                    self.newsCount = newsResponse.numResults
                    self.newsList = newsResponse.results
                    break
                case .failure(_):
                    print("error")
                    break
                }
            }
        }
        
    }
    
    var body: some View {
            ScrollView {
                VStack {
                    if self.newsCount <= 0 {
                        ProgressView().frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    } else {
                        ForEach (newsList) { newsElement in
                            NavigationLink {
                                DetailedNewsComponent(newsElement: newsElement).navigationTitle(newsElement.section).frame(alignment: .top)
                            } label: {
                                NewsComponent(newsElement: newsElement)
                            }
                        }
                    }
                }
            }.refreshable {
                print("refreshed")
                self.onAppear() }
            .background(Constants.Colors.mainBackgroundColor)
        .onAppear { self.onAppear() }
    }
}
