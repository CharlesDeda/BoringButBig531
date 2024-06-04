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
      List {
        ForEach(plan.weights.indices, id: \.self) { index in
          HStack {
            Section {
              Text("\(plan.reps[index])")
              
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("\(plan.weights[index])")
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
