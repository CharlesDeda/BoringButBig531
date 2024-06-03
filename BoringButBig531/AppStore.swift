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

  var isProfileComplete: Bool {
    !lifts.allSatisfy { $0.oneRepMax == 0 }
  }

}
