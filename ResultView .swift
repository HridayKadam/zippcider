import SwiftUI

struct ResultView: View {
    var gameMode: StartGameView.GameMode
    var reactionTimeP1: Double?
    var reactionTimeP2: Double?
    @State private var showLeaderboard = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                if gameMode == .single {
                    Text("Your Score: \(formattedScore(score: reactionTimeP1)) seconds")
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.5)))
                        .shadow(radius: 5)
                } else {
                    VStack(spacing: 20) {
                        Text("Player 1: \(formattedScore(score: reactionTimeP1)) seconds")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("Player 2: \(formattedScore(score: reactionTimeP2)) seconds")
                            .font(.title2)
                            .foregroundColor(.red)
                        Text(winnerText())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.5)))
                    .shadow(radius: 5)
                }
                
                HStack {
                    if gameMode == .multiplayer {
                        Button(action: {
                            shareScore(player: "Player 1", score: reactionTimeP1)
                        }) {
                            Text("Share Player 1 Score")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: 250)
                                .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        Button(action: {
                            shareScore(player: "Player 2", score: reactionTimeP2)
                        }) {
                            Text("Share Player 2 Score")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: 250)
                                .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
                
                Button(action: {
                    showLeaderboard = true
                }) {
                    Text("View Leaderboard")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
                .sheet(isPresented: $showLeaderboard) {
                    LeaderboardView(gameMode: gameMode, reactionTimeP1: reactionTimeP1, reactionTimeP2: reactionTimeP2)
                }
            }
        }
    }
    
    func winnerText() -> String {
        guard let timeP1 = reactionTimeP1, let timeP2 = reactionTimeP2 else {
            return "Awaiting Results..."
        }
        if timeP1 < timeP2 {
            return "🎉 Player 1 Wins!"
        } else if timeP2 < timeP1 {
            return "🎉 Player 2 Wins!"
        } else {
            return "It's a Tie!"
        }
    }
    
    // Helper function to format the score in seconds
    func formattedScore(score: Double?) -> String {
        guard let score = score else { return "0.00" }
        return String(format: "%.2f", score)
    }
    
    // Share score functionality
    func shareScore(player: String, score: Double?) {
        guard let score = score else { return }
        let formattedScore = String(format: "%.2f", score)
        let message = "\(player)'s score in Zipp: \(formattedScore) seconds! Can you beat it? Download Zipp now!"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }
}
