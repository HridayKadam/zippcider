import SwiftUI

struct LeaderboardView: View {
    var gameMode: StartGameView.GameMode
    var reactionTimeP1: Double?
    var reactionTimeP2: Double?
    
    @Environment(\.presentationMode) var presentationMode  // For dismissing the view
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("🏆 Leaderboard 🏆")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                if gameMode == .single {
                    Text("Your Zipp Score: \(formattedScore(score: reactionTimeP1)) seconds")
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
                
                // Share Buttons for Both Players in Multiplayer
                if gameMode == .multiplayer {
                    HStack {
                        shareButton(playerNumber: 1, score: reactionTimeP1)
                        shareButton(playerNumber: 2, score: reactionTimeP2)
                    }
                    .padding(.top, 20)
                } else {
                    shareButton(playerNumber: 1, score: reactionTimeP1)  // Single-player button
                }
            }
            .padding()
        }
    }
    
    func formattedScore(score: Double?) -> String {
        guard let score = score else { return "0.00" }
        return String(format: "%.2f", score)
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
    
    // Share Button for Each Player
    func shareButton(playerNumber: Int, score: Double?) -> some View {
        Button(action: {
            guard let score = score else { return }
            let scoreText = "Player \(playerNumber) Zipp Score: \(formattedScore(score: score)) seconds. Try it now!"
            shareScore(text: scoreText)
        }) {
            Text("Share Player \(playerNumber)'s Score")
                .font(.title2)
                .padding()
                .frame(maxWidth: 200)
                .background(LinearGradient(gradient: Gradient(colors: playerNumber == 1 ? [.blue, .green] : [.red, .yellow]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
    }
    
    // Function to handle sharing
    func shareScore(text: String) {
        let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
    }
}
