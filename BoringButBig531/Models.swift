import Foundation

struct Lift: Identifiable {
  let id: UUID
  var name: String
  var weight = 0.0
  var reps = 0.0
  
  var oneRepMax: Double {
    weight * reps
    //Nick
  }
}
