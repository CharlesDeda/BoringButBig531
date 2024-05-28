import SwiftUI

struct EmptyProfileView: View {
  @Binding var lifts: [Lift]
  @Binding var isSheetPresented: Bool
  
  var body: some View {
    VStack(spacing: 16) {
      Text("Get Started")
        .bold()
        .font(.title)
      
      Text("Before we can generate a plan, you need to complete your profile")
        .foregroundColor(.secondary)
        .padding(.bottom)
      
      Button(action: {
        isSheetPresented.toggle()
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
        isSheetPresented.toggle()
      }) {
        Image(systemName: "person.crop.circle")
      }
    }
  }
}

struct EmptyProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      EmptyProfileView(
        lifts: .constant([
          Lift(id: UUID(), name: "Deadlift"),
          Lift(id: UUID(), name: "Squat"),
          Lift(id: UUID(), name: "Bench"),
          Lift(id: UUID(), name: "Press")
        ]),
        isSheetPresented: .constant(false)
      )
    }
  }
}
