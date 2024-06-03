import Foundation

/*
 We want to represent each week with a number of reps per set
 week 1: 5,5,5,5,5
 week 2: 5,5,3,5,5
 week 3: 5,3,1,3,5
 week 4: 5,3,3,3,3
 */


struct Lift: Identifiable {
  let id: UUID
  var name: LiftType
  var weight = 0.0
  var reps = 0.0
  var isComplete = false
  var set = 0
  
  var oneRepMax: Int {
    Int(round(weight/(1.0278 - 0.0278 * reps)))
  }
  
  func getPlan(week: Int) -> [Int]? {
    let values = [
      1: [0.55, 0.65, 0.75, 0.65, 0.55],
      2: [0.60, 0.70, 0.85, 0.70, 0.60],
      3: [0.60, 0.75, 0.95, 0.75, 0.60],
      4: [0.40, 0.50, 0.55, 0.50, 0.40]
    ]
    return values[week].flatMap { $0.map { abs(Int($0 * Double(oneRepMax))) } }
  }
  func getReps(week: Int) -> [Int] {
    let values = [
      1: [5, 5, 5, 5, 5],
      2: [5, 5, 3, 5, 5],
      3: [5, 3, 1, 3, 5],
      4: [5, 5, 5, 5, 5]
    ]
    return values[week]!
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
  
  enum LiftType: String, CustomStringConvertible, Equatable {
    var description: String {
      rawValue.capitalized
    }
    
    case deadlift
    case squat
    case bench
    case press
  }
  
  func getLift(name: LiftType, lifts: [Lift]) -> Lift? {
    for lift in lifts {
      if lift.name == name {
        return lift
      }
    }
    return nil
  }
  
  struct ExerciseSet {
    let sets: [Int]
  }
}
