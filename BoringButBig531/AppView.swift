import SwiftUI

struct AppView: View {
  @State var isSheetPresented = false
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
          WorkoutListView(lifts: $lifts, isSheetPresented: $isSheetPresented)
        } else {
          EmptyProfileView(lifts: $lifts, isSheetPresented: $isSheetPresented)
        }
      }
      .sheet(isPresented: $isSheetPresented, content: {
        ProfileView(lifts: $lifts)
      })
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
