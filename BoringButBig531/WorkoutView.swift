//
//  WeeklyView.swift
//  BoringButBig531
//
//  Created by Nick Deda on 5/29/24.
//

import SwiftUI

struct WorkoutView: View {
  @Binding var lifts: [Lift]
  @Environment(\.dismiss) var dismiss
  let selectedWeek: Int
  
  var body: some View {
    List {
      ForEach(lifts) { lift in
        Section(lift.weekday) {
          NavigationLink(lift.name.description) {
            PlanView(lift: getLift(name: lift.name, lifts: lifts) ?? Lift(id: UUID(), name: .deadlift), selectedWeek: selectedWeek)
          }
        }
      }
    }
    .navigationTitle("Week \(selectedWeek)")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        HomeView(lifts: $lifts, isSheetPresented: .constant(true))
      }
    }
  }
}

extension Lift {
  var weekday: String {
    switch name {

    case .deadlift:
      return "Monday"
    case .squat:
      return "Tuesday"
    case .bench:
      return "Thursday"
    case .press:
      return "Friday"
    }
  }
  
//  var weekday: String {
//    if name == .deadlift {
//      return "Monday"
//    } else if name == .squat {
//      return "Tuesday"
//    } else if name == .bench {
//      return "Thursday"
//    } else if name == .press {
//      return "Friday"
//    } else {
//      return "Nothing"
//    }
//  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      WorkoutView(lifts: .constant([
        Lift(id: UUID(), name: .deadlift),
        Lift(id: UUID(), name: .squat),
        Lift(id: UUID(), name: .bench),
        Lift(id: UUID(), name: .press)
      ]), selectedWeek: 1
      )
    }
  }
}
