//
//  ContentView.swift
//  BoringButBig531
//
//  Created by Nick Deda on 5/28/24.
//

import SwiftUI


struct ContentView: View {
  
  var body: some View {
    NavigationStack {
      VerticalSmileys()
      .navigationTitle("Profile")
    }
  }
}

struct Lift: Identifiable {
  let id: UUID
  let name: String
  let oneRepMax: Double
}


struct VerticalSmileys: View {
  let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
  let lifts: [Lift] = [
    Lift(id: UUID(), name: "Deadlift", oneRepMax: 565),
    Lift(id: UUID(), name: "Squat", oneRepMax: 485),
    Lift(id: UUID(), name: "Bench", oneRepMax: 315),
    Lift(id: UUID(), name: "Press", oneRepMax: 205),

  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 0) {
        ForEach(lifts) { value in
          VStack {
            Text(value.name)
            Text("\(value.oneRepMax)")
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
          .background {
            Color(.systemGray5)
          }
          .cornerRadius(8)
          .padding(8)
        }
      }
      .padding(.horizontal)
    }
  }
  
  
  private func emoji(_ value: Int) -> String {
    guard let scalar = UnicodeScalar(value) else { return "?" }
    return String(Character(scalar))
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
