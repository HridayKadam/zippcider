import SwiftUI

struct GameView: View {
    var gameMode: StartGameView.GameMode
    
    @State private var isGameActive = false
    @State private var showLeaderboard = false
    @State private var reactionTimeP1: Double?
    @State private var reactionTimeP2: Double?
    @State private var startTimeP1: Date?
    @State private var startTimeP2: Date?
    @State private var waitingForTapP1 = false
    @State private var waitingForTapP2 = false
    
    var body: some View {
        ZStack {
            // Soft gradient background
            LinearGradient(gradient: Gradient(colors: [.white, .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            if showLeaderboard {
                LeaderboardView(gameMode: gameMode, reactionTimeP1: reactionTimeP1, reactionTimeP2: reactionTimeP2)
            } else {
                VStack(spacing: 30) {
                    if gameMode == .single {
                        playerSection(playerNumber: 1, waitingForTap: $waitingForTapP1, startTime: $startTimeP1, reactionTime: $reactionTimeP1)
                    } else {
                        playerSection(playerNumber: 1, waitingForTap: $waitingForTapP1, startTime: $startTimeP1, reactionTime: $reactionTimeP1)
                        playerSection(playerNumber: 2, waitingForTap: $waitingForTapP2, startTime: $startTimeP2, reactionTime: $reactionTimeP2)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            startGame()
        }
    }
    
    func playerSection(playerNumber: Int, waitingForTap: Binding<Bool>, startTime: Binding<Date?>, reactionTime: Binding<Double?>) -> some View {
        VStack {
            Text("Player \(playerNumber)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black.opacity(0.8))
            
            Button(action: {
                if waitingForTap.wrappedValue {
                    let reactionTimeValue = Date().timeIntervalSince(startTime.wrappedValue ?? Date()) * 1000
                    reactionTime.wrappedValue = reactionTimeValue
                    waitingForTap.wrappedValue = false
                    checkIfGameFinished()
                }
            }) {
                Circle()
                    .fill(waitingForTap.wrappedValue ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                    .frame(width: 140, height: 140)
                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                    .overlay(
                        Text(waitingForTap.wrappedValue ? "TAP!" : "WAIT")
                            .font(.headline)
                            .foregroundColor(.white)
                    )
            }
            .disabled(!waitingForTap.wrappedValue)
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
        .shadow(radius: 10)
    }
    
    func startGame() {
        waitingForTapP1 = false
        waitingForTapP2 = false
        
        let delayP1 = Double.random(in: 2...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + delayP1) {
            waitingForTapP1 = true
            startTimeP1 = Date()
        }
        
        if gameMode == .multiplayer {
            let delayP2 = Double.random(in: 2...5)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayP2) {
                waitingForTapP2 = true
                startTimeP2 = Date()
            }
        }
    }
    
    func checkIfGameFinished() {
        if reactionTimeP1 != nil && (gameMode == .single || reactionTimeP2 != nil) {
            showLeaderboard = true
        }
    }
}
