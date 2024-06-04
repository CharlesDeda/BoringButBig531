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
  
  var plan: Plan {
    appStore.getPlan(lift: lift)
  }
  
  var body: some View {
    VStack {
      Table(of: Plan.self) {
        TableColumn("Weight") { weight in
          Text("\(weight.weights[0])")
        }
        TableColumn("Reps") { reps in
          Text("\(reps.reps[0])")
        }
      } rows: {
        TableRow(Plan(weights: plan.weights, reps: plan.reps))
      }
      

//      List {
//        ForEach(plan.weights.indices, id: \.self) { index in
//          HStack {
//            Text("\(plan.reps[index])")
//              .frame(maxWidth: .infinity, alignment: .leading)
//            Text("\(plan.weights[index])")
//          }
//        }
//      }
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
