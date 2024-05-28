import SwiftUI

struct AppView: View {
  @State var lifts: [Lift] = [
    Lift(id: UUID(), name: "Deadlift"),
    Lift(id: UUID(), name: "Squat"),
    Lift(id: UUID(), name: "Bench"),
    Lift(id: UUID(), name: "Press")
  ]
  var isProfileComplete: Bool {
    !lifts.allSatisfy { $0.oneRepMax == 0 }
  }
  
  var body: some View {
    NavigationStack {
      Group {
        if isProfileComplete {
          WorkoutListView(lifts: $lifts)
        } else {
          EmptyProfileView(lifts: $lifts)
        }
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
