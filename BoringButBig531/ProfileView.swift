import SwiftUI

struct ProfileView: View {
  @ObservedObject var appStore: AppStore
  @FocusState var focus: ProfileFocus?
  @State var lifts: [Lift]
  let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
  @Environment(\.dismiss) var dismiss
  
  init(appStore: AppStore) {
    self.appStore = appStore
    self.lifts = appStore.lifts
  }
  
  var body: some View {
    NavigationStack {
      //      TextField("Please enter your name here", text: $appStore.name)
      //        .textFieldStyle(.roundedBorder)
      //        .cornerRadius(8)
      //        .padding()
      //        .frame(width: 200, alignment: .trailing)
      ScrollView {
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach($lifts) { $value in
            VStack {
              Text(value.liftType.description)
                .font(.headline)
              HStack {
                Text("Weight")
                  .bold()
                  .frame(width: 80, alignment: .leading)
                TextField("\(value.weight)", value: $value.weight, formatter: NumberFormatter())
                  .keyboardType(.decimalPad)
                  .frame(width: 50)
                  .focused($focus, equals: .weight(value.id))
                  .submitLabel(.next)
                  .onSubmit {
                    focus = .reps(value.id)
                  }
              }
              HStack {
                Text("Reps")
                  .bold()
                  .frame(width: 80, alignment: .leading)
                TextField("\(value.reps)", value: $value.reps, formatter: NumberFormatter())
                  .keyboardType(.decimalPad)
                  .frame(width: 50)
                  .focused($focus, equals: .reps(value.id))
                  .submitLabel(.done)
                  .onSubmit {
                    print("value: \(value)")
                    var index = lifts.firstIndex(where: { $0.id == value.id }) ?? -1
                    index += 1
                    if index < lifts.count {
                      // if index > count, make it zero, you can loop around
                      let nextValue = lifts[index % lifts.count]
                      focus = .weight(nextValue.id)
                    } else {
                      focus = nil

                    }
                  }
                
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
          ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            
            Button("Next") {    
              if let nextField = focus?.liftID {
                var index = lifts.firstIndex(where: { $0.id == nextField }) ?? -1
                if focus == .weight(nextField) {
                  focus = .reps(nextField)
                } else {
                  focus = nil                }
              }
            }
          }
        }
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
              dismiss()
            }
            .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                  appStore.updateLifts(lifts)
                  dismiss()
                }
              }
            }
          }
        }
      }
    }
  }
//  func toggleTextField() {
//    if focus == .reps {
//      focus = .weight
//    } else {
//      focus = .weight
//    }
//  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hello World").sheet(isPresented: .constant(true)) {
      ProfileView(appStore: AppStore())
    }
  }
}
