import SwiftUI

struct WorkoutListView: View {
  @Binding var lifts: [Lift]
  
  var body: some View {
    List {
      ForEach(lifts) { lift in
        HStack {
          /*@START_MENU_TOKEN@*/Text(lift.name)/*@END_MENU_TOKEN@*/
          Text("\(lift.oneRepMax.description)")
        }
      }
    }
    .navigationTitle("Home")
    .toolbar {
      NavigationLink(destination: { ProfileView(lifts: $lifts) }) {
        Image(systemName: "person.crop.circle")
      }
    }
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      WorkoutListView(lifts: .constant([
        Lift(id: UUID(), name: "Deadlift"),
        Lift(id: UUID(), name: "Squat"),
        Lift(id: UUID(), name: "Bench"),
        Lift(id: UUID(), name: "Press")
      ]))
    }
  }
}
