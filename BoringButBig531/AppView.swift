import SwiftUI

struct AppView: View {
  @StateObject var appStore = AppStore()
  @State var name = ""
  
  var body: some View {
    NavigationStack {
      Group {
        if appStore.isProfileComplete {
          HomeView(appStore: appStore)
        } else {
          EmptyProfileView(appStore: appStore)
        }
      }
      .sheet(isPresented: $appStore.isSheetPresented, content: {
        ProfileView(appStore: appStore)
      })
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
