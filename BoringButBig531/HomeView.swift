import SwiftUI

struct HomeView: View {
  @StateObject var appStore: AppStore
  let weeks = [1,2,3,4]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(weeks, id: \.self) { value in
          HStack {
            NavigationLink("Week \(value)") {
              WorkoutView(appStore: appStore, selectedWeek: value)
            }
          }
        }
      }
      .navigationTitle("Home")
      .toolbar {
        Button(action: {
          appStore.isSheetPresented.toggle()
        }) {
          Image(systemName: "person.crop.circle")
        }
      }
    }
  }
}

struct WorkoutListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      HomeView(appStore: AppStore())
    }
  }
}
