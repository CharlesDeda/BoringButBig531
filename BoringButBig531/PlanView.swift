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
  
  var bbbPlan: Plan {
    appStore.getBBBPlan(lift: lift)
  }
  
  var body: some View {
    VStack {
      List {
        Section("5/3/1") {
          ForEach(plan.weights.indices) { index in
            HStack {
              Text(plan.weights[index], format: .number)
              Text("\(plan.reps[index])")
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
          }
        }
      }
      List {
        Section("Boring But Big") {
          ForEach(bbbPlan.weights.indices) { index in
            HStack {
              Text(bbbPlan.weights[index], format: .number)
              Text("\(bbbPlan.reps[index])")
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
          }
        }
      }
    }
    .navigationTitle("Boring But Big")
  }
}

struct PlanView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PlanView(lift: Lift(id: UUID(), name: .deadlift), appStore: AppStore())
    }
  }
}
