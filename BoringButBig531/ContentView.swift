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
      ProfileView()
      .navigationTitle("Profile")
    }
  }
}

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


struct ProfileView: View {
  let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
  @State var lifts: [Lift] = [
    Lift(id: UUID(), name: "Deadlift"),
    Lift(id: UUID(), name: "Squat"),
    Lift(id: UUID(), name: "Bench"),
    Lift(id: UUID(), name: "Press")
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 0) {
        ForEach($lifts) { $value in
          VStack {
            Text(value.name)
              .font(.headline)
            HStack {
              Text("Weight")
                .bold()
                .frame(width: 80, alignment: .leading)
              TextField("\(value.weight)", value: $value.weight, formatter: NumberFormatter())
            }
            HStack {
              Text("Reps")
                .bold()
                .frame(width: 80, alignment: .leading)
              TextField("\(value.reps)", value: $value.reps, formatter: NumberFormatter())
            }
            HStack {
              Text("1rm")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("\(value.oneRepMax.description)")
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
          .background {
            Color(.systemGray5)
          }
          .textFieldStyle(.roundedBorder)
          .multilineTextAlignment(.trailing)
          .cornerRadius(8)
          .padding(8)
        }
      }
      .padding(.horizontal)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
