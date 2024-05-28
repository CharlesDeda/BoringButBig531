import SwiftUI

struct WorkoutListView: View {
  var body: some View {
    Text("Profile is complete")
      .navigationTitle("Home")
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      WorkoutListView()
    }
  }
}
