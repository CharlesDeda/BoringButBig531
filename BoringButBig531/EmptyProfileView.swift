import SwiftUI

struct EmptyProfileView: View {
  var body: some View {
    VStack(spacing: 16) {
      Text("Get Started")
        .bold()
        .font(.title)
      
      Text("Before we can generate a plan, you need to complete your profile")
        .foregroundColor(.secondary)
        .padding(.bottom)
      
      NavigationLink(destination: { ProfileView() }) {
        Text("Edit Profile")
      }
      .buttonStyle(.borderedProminent)
      .padding(.horizontal)
    }
    .navigationTitle("Home")
    .multilineTextAlignment(.center)
  }
}

struct EmptyProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      EmptyProfileView()
    }
  }
}
