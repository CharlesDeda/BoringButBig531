import SwiftUI

struct EmptyProfileView: View {
  @StateObject var appStore: AppStore
  
  var body: some View {
    VStack(spacing: 16) {
      Text("Get Started")
        .bold()
        .font(.title)
      
      Text("Before we can generate a plan, you need to complete your profile")
        .foregroundColor(.secondary)
        .padding(.bottom)
      
      Button(action: {
        appStore.isSheetPresented.toggle()
      }) {
        Text("Edit Profile")
      }
      .buttonStyle(.borderedProminent)
      .padding(.horizontal)
    }
    .navigationTitle("Home")
    .multilineTextAlignment(.center)

    .toolbar {
      Button(action: {
        appStore.isSheetPresented.toggle()
      }) {
        Image(systemName: "person.crop.circle")
      }
    }
  }
}

struct EmptyProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      EmptyProfileView(appStore: AppStore())
    }
  }
}
