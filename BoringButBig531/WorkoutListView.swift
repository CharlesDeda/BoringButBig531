import SwiftUI

struct WorkoutListView: View {
  @Binding var lifts: [Lift]
  @State var isSheetPresented = false
  
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
    .sheet(isPresented: $isSheetPresented, content: {
      ProfileView(lifts: $lifts)
    })
    .toolbar {
      Button(action: {
        isSheetPresented.toggle()
      }) {
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
