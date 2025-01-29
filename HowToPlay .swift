import SwiftUI

struct HowToPlayView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("How to Play")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("1. Tap the screen as fast as you can when prompted.")
                Text("2. In multiplayer, both players tap their own side.")
                Text("3. The fastest reaction time wins.")
                Text("4. If you tap too early, you'll get a penalty.")
                Text("5. Press 'Play Again' to try again.")
            }
            .font(.title3)
            .foregroundColor(.black.opacity(0.7))
            .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 40)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
