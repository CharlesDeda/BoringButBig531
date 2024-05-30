import Foundation

struct Lift: Identifiable {
  let id: UUID
  var name: LiftType
  var weight = 0.0
  var reps = 0.0
  var isComplete = false

  
  var oneRepMax: Double {
    round(weight/(1.0278 - 0.0278 * reps))
  }
  var plans: [Plan] {
    guard weight > 0 && reps > 0 else {
      return []
    }
    return [1,2,3,4].compactMap { week in
      if let a = getPlan(week: week) {
        return Plan(week: week, plan: a)
      }
      return nil
    }
  }
  func getPlan(week: Int) -> [Double]? {
    let values = [
      1: [0.55, 0.65, 0.75, 0.65, 0.55],
      2: [0.60, 0.70, 0.85, 0.70, 0.60],
      3: [0.60, 0.75, 0.95, 0.75, 0.60],
      4: [0.40, 0.50, 0.55, 0.50, 0.40]
    ]
    return values[week].flatMap { $0.map { abs($0 * oneRepMax) } }
  }
}


struct Plan: Identifiable {
  var id: Int { week }
  let week: Int
  let plan: [Double]
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

//you have a struct called plan that has a week and a plan, you also have a func that returns the set to you called get plan, you also have a func called getLift which returns a lift to you, you need to write a view that will have a selectedWeek, and then that selected week gets passed to the getPlan func, which has the lift from getLift (contains the weight and reps for that lift)
