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
  @Environment(\.dismiss) var dismiss
  @State var lift: Lift
  @StateObject var appStore: AppStore
  
  var plan: Plan {
    appStore.getPlan(lift: lift)
  }
  
  
  var body: some View {
    Table(of: Plan.self) {
      TableColumn("Weight", value: \.weights.description)
      TableColumn("Reps", value: \.reps.description)
    } rows: {
      TableRow(plan)
    }
  }
}

struct PlanView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PlanView(lift: Lift(id: UUID(), name: .deadlift), appStore: AppStore())
    }
  }
}
