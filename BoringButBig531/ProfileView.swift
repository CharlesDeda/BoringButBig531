import SwiftUI

struct ProfileView: View {
  @StateObject var appStore: AppStore
  let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      TextField("Please enter your name here", text: $appStore.name)
        .textFieldStyle(.roundedBorder)
        .cornerRadius(8)
        .padding()
        .frame(width: 200, alignment: .trailing)
      ScrollView {
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach($appStore.lifts) { $value in
            VStack {
              Text(value.name.description)
                .font(.headline)
              HStack {
                Text("Weight")
                  .bold()
                  .frame(width: 80, alignment: .leading)
                TextField("\(value.weight)", value: $value.weight, formatter: NumberFormatter())
                  .keyboardType(.decimalPad)
              }
              HStack {
                Text("Reps")
                  .bold()
                  .frame(width: 80, alignment: .leading)
                TextField("\(value.reps)", value: $value.reps, formatter: NumberFormatter())
                  .keyboardType(.decimalPad)
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
            .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                  dismiss()
                }
              }
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
      ProfileView(appStore: AppStore())
    }
  }
}
