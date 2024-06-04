import Foundation
import SwiftUI

final class AppStore: ObservableObject {
  @Published var isSheetPresented = false
  
  @Published var lifts: [Lift] = [
    Lift(id: UUID(), name: .deadlift),
    Lift(id: UUID(), name: .squat),
    Lift(id: UUID(), name: .bench),
    Lift(id: UUID(), name: .press)
  ]
  
  @Published var name: String = ""
  let selectedWeek = 1

  var isProfileComplete: Bool {
    !lifts.allSatisfy { $0.oneRepMax == 0 }
  }
  
  func getPlan(lift: Lift) -> Plan {
    return lift.getPlan(week: self.selectedWeek)
  }
  
  func getLift(name: LiftType) -> Lift? {
    for lift in lifts {
      if lift.name == name {
        return lift
      }
    }
    return nil
  }
}
