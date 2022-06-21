//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Aakash Kumar on 03/02/22.
//

import SwiftUI

struct ContentView: View {
    let choice = ["Rock", "Paper", "Scissors"]
    let choiceEmoji = ["🪨", "📄", "✂️"]
    
    @State private var selectedOpt = Int.random(in: 0...2)
    @State private var appChoice = "Rock"
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var numOfQues = 0
    @State private var isTheEnd = false
    @State private var gameOver = "Game Over!"
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(red: 0.21, green: 0.65, blue: 0.76), Color(UIColor.systemBackground)]), center: .center,
            startRadius: 10, endRadius: 670)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Player's Score: \(score)")
                    Text("App's move: \(choice[selectedOpt])")
                    if shouldWin {
                        Text("Player should win")
                    } else {
                        Text("Player should lose")
                    }
                }
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(maxWidth: 300)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer()
                
                HStack {
                    ForEach (0..<3) { number in
                        Button {
                            buttonPressed(number)
                        } label: {
                            Spacer()
                            Text("\(choiceEmoji[number])")
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .alert(gameOver, isPresented: $isTheEnd) {
                Button("New Game", action: reset)
            } message: {
                Text("Your final score is: \(score)")
            }
        }
    }
    
    func updateUI() {
        selectedOpt = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func buttonPressed(_ number: Int) {
        numOfQues += 1
        switch choice[selectedOpt] {
        case "Rock":
            if (choice[number] == "Paper") {
                if (shouldWin) {
                    score += 1
                } else {
                    score -= 1
                }
            } else if (choice[number] == "Scissors") {
                if (shouldWin) {
                    score -= 1
                } else {
                    score += 1
                }
            }
        case "Paper":
            if (choice[number] == "Rock") {
                if (shouldWin) {
                    score -= 1
                } else {
                    score += 1
                }
            } else if (choice[number] == "Scissors") {
                if (shouldWin) {
                    score += 1
                } else {
                    score -= 1
                }
            }
        case "Scissors":
            if (choice[number] == "Paper") {
                if (shouldWin) {
                    score -= 1
                } else {
                    score += 1
                }
            } else if (choice[number] == "Rock") {
                if (shouldWin) {
                    score += 1
                } else {
                    score -= 1
                }
            }
        default:
            score = score
        }
        if (numOfQues == 10) {
            isTheEnd = true
        } else {
            updateUI()
        }
    }
    
    func reset() {
        score = 0
        numOfQues = 0
        isTheEnd = false
        updateUI()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
