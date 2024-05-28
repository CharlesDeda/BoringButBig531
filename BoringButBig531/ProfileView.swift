import SwiftUI

struct ProfileView: View {
  let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
  @Binding var lifts: [Lift]
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
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
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
              dismiss()
            }
          }
        }
      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hello World").sheet(isPresented: .constant(true)) {
      ProfileView(lifts: .constant([
        Lift(id: UUID(), name: "Deadlift"),
        Lift(id: UUID(), name: "Squat"),
        Lift(id: UUID(), name: "Bench"),
        Lift(id: UUID(), name: "Press")
      ]))
    }
  }
}
