import Foundation

/*
 We want to represent each week with a number of reps per set
 week 1: 5,5,5,5,5
 week 2: 5,5,3,5,5
 week 3: 5,3,1,3,5
 week 4: 5,3,3,3,3
 */

/*
  
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

/**
 A lift is of a type either a squat, bench, deadlift, or overhead press
 Each lift has a one rep max
 Each lift calculates what set to represent based on the liftType and oneRepMax
 There can be an array of lifts, in this app there is an array that has a liit for each type
 */
struct Lift: Identifiable, Equatable {
  let id: UUID
  var liftType: LiftType
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
  
  func getBBB(week: Int) -> Plan {
    let values = [
      1: Plan(weights: [0.50, 0.50, 0.50, 0.50, 0.50], reps: [10,10,10,10,10]),
      2: Plan(weights: [0.50, 0.50, 0.50, 0.50, 0.50], reps: [10,10,10,10,10]),
      3: Plan(weights: [0.50, 0.50, 0.50, 0.50, 0.50], reps: [10,10,10,10,10]),
      4: Plan(weights: [0.50, 0.50, 0.50, 0.50, 0.50], reps: [10,10,10,10,10])
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

enum LiftType: String, CustomStringConvertible, Equatable, Codable {
  var description: String {
    rawValue.capitalized
  }
  
  case deadlift
  case squat
  case bench
  case press
  
  
  /**
   Return a file path relative to our app's liftsDatabase and based to the self.liftType
   */
  fileprivate var jsonFileUrl: URL {
    Lift.liftsDatabase.appendingPathComponent("\(self.rawValue).json")
  }
}

extension Lift {
  var weekday: String {
    switch liftType {
      
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

// MARK: - Persistence -
extension Lift: Codable {
  // default.store file in your app's sandbox
  // ie: ../Library/Application\ Support/lifts.database
  // this is where core data goes
  // it will be created automagically when you SDClient.init()
  static let liftsDatabase: URL = {
    if let folder = FileManager.default.urls(for: .applicationSupportDirectory, in: .allDomainsMask).first {
      print("liftsDatabase: \(folder.path)")
      let rv = folder.appendingPathComponent("lifts.database")
      try? FileManager.default.createDirectory(at: rv, withIntermediateDirectories: true)
      return rv
    }
    return URL.temporaryDirectory
  }()
  
  /**
   Will load from persistence or if no persistence will return a fresh instance
   We need the filename to read the json data and create an instance from it
   if no saved data return fresh instance
   */
  static func fetch(liftType: LiftType) -> Self {
    let jsonFileUrl = liftType.jsonFileUrl

    print("lift: \(jsonFileUrl.path)")
    do {
      let data = try Data.init(contentsOf: jsonFileUrl)
      let decoder = JSONDecoder()
      let item = try decoder.decode(Lift.self, from: data)

      return item
    } catch {
      print("error: \(error)")
    }
    return .init(id: UUID(), liftType: liftType)
  }
  
  /**
   Will store into persistence an instance
   We need json data and a file name from the item to store it
   */
  static func store(lift: Lift) -> Void {
    let jsonFileUrl = lift.liftType.jsonFileUrl

    print("lift: \(lift)")
    print("lift: \(jsonFileUrl.path)")
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(lift)
      try data.write(to: jsonFileUrl)
      
      let json = String.init(data: data, encoding: .utf8) ?? ""
      print("lift: \(json)")
    } catch {
      print("error: \(error)")
    }
  }
}
