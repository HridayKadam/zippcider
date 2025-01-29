import SwiftUI

struct ContentView: View {
    @State private var gameMode: StartGameView.GameMode? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Choose Game Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                
                NavigationLink(destination: GameView(gameMode: .single)) {
                    Text("Single Player")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .scaleEffect(1.1)
                }
                .padding(.horizontal, 40)
                
                NavigationLink(destination: GameView(gameMode: .multiplayer)) {
                    Text("Multiplayer")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .scaleEffect(1.1)
                }
                .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}
