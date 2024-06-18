//
//  WeeklyView.swift
//  BoringButBig531
//
//  Created by Nick Deda on 5/29/24.
//

import SwiftUI

struct WorkoutView: View {
  @StateObject var appStore: AppStore
  let selectedWeek: Int
  @Environment(\.dismiss) var dismiss

  
  var body: some View {
    List {
      ForEach(appStore.lifts) { lift in
        Section(lift.weekday) {
          NavigationLink(lift.liftCompliments) {
            PlanView(lift: appStore.getLift(name: lift.liftType) ?? Lift(id: UUID(), liftType: .deadlift), appStore: appStore)
          }
        }
      }
    }
    .navigationTitle("Week \(selectedWeek)")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        HomeView(appStore: appStore)
      }
    }
  }
}
  


struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      WorkoutView(appStore: AppStore(), selectedWeek: 1
      )
    }
  }
}
