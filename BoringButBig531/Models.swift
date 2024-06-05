import Foundation

/*
 We want to represent each week with a number of reps per set
 week 1: 5,5,5,5,5
 week 2: 5,5,3,5,5
 week 3: 5,3,1,3,5
 week 4: 5,3,3,3,3
 */

struct Plan: Identifiable {
  let id = UUID()
  static var empty: Self = .init(weights: [0,0,0,0,0], reps: [0,0,0,0,0])
  var isComplete = false
  var weights: [Double]
  var reps: [Int]
  
  func newSet(oneRepMax: Int) -> Self {
    var copy = self
    
    copy.weights = weights.map {
      abs($0 * Double(oneRepMax))
    }
    return copy
  }
}


//func getReps(_ lift: Lift) -> (_ week: Int) -> Set? {
//}
//
//func getReps(_ store: AppStore) -> (_ lift: List) -> (_ week: Int) -> Set? {
//}

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

  // June 4, 2024
  // Lesson
  // 1. WHERE DO WE PLACE STUFF, ie: lines of code, functions, declarations, types etc ...
  // 2. Strive to Eliminate Optionals
  // 3. Use explicit names, ie: LiftSet and not Set, do not define a struct called Struct, or Array or Set
  
  func getPlan(week: Int) -> Plan {
    let values = [
      1: Plan(weights: [0.55, 0.65, 0.75, 0.65, 0.55], reps: [5,5,5,5,5]),
      2: Plan(weights: [0.60, 0.70, 0.85, 0.70, 0.60], reps: [5,5,3,5,5]),
      3: Plan(weights: [0.60, 0.75, 0.95, 0.75, 0.60], reps: [5,3,1,3,5]),
      4: Plan(weights: [0.40, 0.50, 0.55, 0.50, 0.40], reps: [5,5,5,5,5])
    ]
    
    guard let set = values[week]
    else {
      return .empty
    }
      
    return set.newSet(oneRepMax: oneRepMax)
  }
//  func getSets(week: Int) -> Set {
//    let values = [
//      1: [5,5,5,5,5],
//      2: [5,5,3,5,5],
//      3: [5,3,1,3,5],
//      4: [5,5,5,5,5]
//    ]
////    var weights1 = getReps(week: week)
////    guard let weights = weights1 else {
////      return nil
////    }
//    return Set(weights: getReps(week: week), reps: values[week])
//  }
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

  struct ExerciseSet {
    let sets: [Int]
  }
}
