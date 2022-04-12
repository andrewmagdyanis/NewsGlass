import SwiftUI

struct ContentView: View {
    var networkManager = NetworkManager()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor (Constants.Colors.mainBackgroundColor)
        UIToolbar.appearance().backgroundColor = UIColor(Constants.Colors.mainBackgroundColor)
        UIWindow.appearance().backgroundColor = UIColor(Constants.Colors.mainBackgroundColor)
        UIScrollView.appearance().backgroundColor = UIColor(Constants.Colors.mainBackgroundColor)
        
    }
    
    var body: some View {
        Group {
            TabView {
                NavigationView {
                    NewsHomePage(apiType: .viewed(period: 7))
                        .navigationBarTitle(Constants.PagesTitles.homepage + " Most Viewed", displayMode: .inline)
                }.navigationViewStyle(.stack)
                .tabItem {
                    Label("Most Viewed", systemImage: "text.magnifyingglass")
                }
                
                NavigationView {
                    NewsHomePage(apiType: .shared(period: 7))
                        .navigationBarTitle(Constants.PagesTitles.homepage + " Most Shared", displayMode: .inline)
                }.navigationViewStyle(.stack)
                .tabItem {
                    Label("Most Shared", systemImage: "arrowshape.bounce.right")
                }
                
                NavigationView {
                    NewsHomePage(apiType: .emailed(period: 7))
                        .navigationBarTitle(Constants.PagesTitles.homepage + " Most Emailed", displayMode: .inline)
                }.navigationViewStyle(.stack)
                .tabItem {
                    Label("Most Emailed", systemImage: "mail")
                }
            }.background(Constants.Colors.mainBackgroundColor)
        }.environmentObject(networkManager)
    }
}
