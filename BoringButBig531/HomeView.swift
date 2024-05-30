import SwiftUI

struct HomeView: View {
  @Binding var lifts: [Lift]
  let weeks = [1,2,3,4]
  @Binding var isSheetPresented: Bool

  
  var body: some View {
    NavigationStack {
      List {
        ForEach(weeks, id: \.self) { value in
          HStack {
            NavigationLink("Week \(value)") {
              WorkoutView(lifts: $lifts, selectedWeek: value)
            }
          }
        }
      }
      .navigationTitle("Home")
      .toolbar {
        Button(action: {
          isSheetPresented.toggle()
        }) {
          Image(systemName: "person.crop.circle")
        }
      }
    }
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      HomeView(
        lifts: .constant([
          Lift(id: UUID(), name: .deadlift),
          Lift(id: UUID(), name: .squat),
          Lift(id: UUID(), name: .bench),
          Lift(id: UUID(), name: .press)
        ]),
        isSheetPresented: .constant(false)
      )
    }
  }
}
