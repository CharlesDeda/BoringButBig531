import SwiftUI

struct AppView: View {
  @State var isProfileComplete = false
  
  var body: some View {
    NavigationStack {
      Group {
        if isProfileComplete {
          WorkoutListView()
        } else {
          EmptyProfileView()
        }
      }
      .onAppear {
        self.isProfileComplete = true
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
