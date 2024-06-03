import SwiftUI

/*
 lifts needs to toggle each set individually
 forEach Binding
 plan should not be a double
 */

//struct Sets {
//  var sets = [0,0,0,0,0]
//  var isComplete = false
//}

struct PlanView: View {
  @State var lift: Lift
  let selectedWeek: Int
  
  var body: some View {
    VStack {
      List {
        if let plan = lift.getPlan(week: selectedWeek) {
          ForEach(plan, id: \.self) { value in
            HStack {
              Text(" \(value)")
//              Toggle("isDone", isOn: $lift.isComplete)
            }
          }
        }
      }
    }
    .navigationTitle("Sets")
  }
}

struct PlanView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PlanView(lift: Lift(id: UUID(), name: .deadlift), selectedWeek: 1)
    }
  }
}
