import SwiftUI

struct StartGameView: View {
    @State private var gameMode: GameMode? = nil
    @State private var showHowToPlay = false
    
    enum GameMode {
        case single, multiplayer
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Text("Zipp")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.blue.opacity(0.8))
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
                    
                    Button(action: {
                        showHowToPlay = true
                    }) {
                        Text("How to Play")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .sheet(isPresented: $showHowToPlay) {
                        HowToPlayView()
                    }
                    
                    NavigationLink(destination: GameView(gameMode: .single)) {
                        Text("Single Player")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    NavigationLink(destination: GameView(gameMode: .multiplayer)) {
                        Text("Multiplayer")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(LinearGradient(gradient: Gradient(colors: [.pink, .orange]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
            }
        }
    }
}
