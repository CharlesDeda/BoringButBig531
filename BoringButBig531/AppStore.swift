import Foundation
import SwiftUI

final class AppStore: ObservableObject {
  @Published var isSheetPresented = false
  
  @Published var lifts: [Lift] = [
    .fetch(liftType: .deadlift),
    .fetch(liftType: .squat),
    .fetch(liftType: .bench),
    .fetch(liftType: .press)
  ]
  
  @Published var name: String = ""
  let selectedWeek = 1

  var isProfileComplete: Bool {
    !lifts.allSatisfy { $0.oneRepMax == 0 }
  }
  
  func getPlan(lift: Lift) -> Plan {
    return lift.getPlan(week: self.selectedWeek)
  }
  
  func getBBBPlan(lift: Lift) -> Plan {
    return lift.getBBB(week: self.selectedWeek)
  }
  
  func getLift(name: LiftType) -> Lift? {
    for lift in lifts {
      if lift.liftType == name {
        return lift
      }
    }
    return nil
  }
  
  func updateLift(_ newValue: Lift) {
    guard let index = lifts.firstIndex(where: { $0.id == newValue.id }),
          lifts[index] != newValue
    else { return }
    
    // we have a new lift with changed values
    // 1. we update our internal array of lifts
    // 2. we store this new lift into the persistence
    lifts[index] = newValue
    Lift.store(lift: newValue)
  }
  
  /**
   we have a new lift with changed values
   1. we update our internal array of lifts
   2. we store this new lift into the persistence
   */
  func updateLifts(_ newValue: [Lift]) {
    lifts = newValue
    lifts.forEach(Lift.store(lift:))
  }
}
