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
  @StateObject var appStore: AppStore
  
  var body: some View {
    VStack {
      List {
        if let plan = lift.getPlan(week: appStore.selectedWeek) {
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
      PlanView(lift: Lift(id: UUID(), name: .deadlift), appStore: AppStore())
    }
  }
}
