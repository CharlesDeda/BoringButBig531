import SwiftUI

struct EmptyProfileView: View {
  @Binding var lifts: [Lift]
  
  var body: some View {
    VStack(spacing: 16) {
      Text("Get Started")
        .bold()
        .font(.title)
      
      Text("Before we can generate a plan, you need to complete your profile")
        .foregroundColor(.secondary)
        .padding(.bottom)
      
      NavigationLink(destination: { ProfileView(lifts: $lifts) }) {
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
      EmptyProfileView(lifts: .constant([
        Lift(id: UUID(), name: "Deadlift"),
        Lift(id: UUID(), name: "Squat"),
        Lift(id: UUID(), name: "Bench"),
        Lift(id: UUID(), name: "Press")
      ]))
    }
  }
}
