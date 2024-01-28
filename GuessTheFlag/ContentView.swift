//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Görkem Güray on 16.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingWrongAnswer = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var correctAnswerText = ""
    @State private var answerState = false
    @State private var answerCount = 0
    @State private var showingGrandResult = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15){
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            self.answerState = flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
        
        .alert(scoreTitle,isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if answerState {
                Text("Your score is \(score)")
            } else {
                Text("\(correctAnswerText)")
            }
        }
        
        .alert("Finished !", isPresented: $showingGrandResult) {
            Button("Restart", action: reset)
        } message: {
            Text("Your score is \(score)")
                .font(.subheadline.weight(.semibold))
        }
        
    }
    
    func flagTapped(_ number: Int) -> Bool {
        answerCount += 1
        var flagTappedResult = false
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            flagTappedResult = true
        } else {
            scoreTitle = "Wrong"
            correctAnswerText = "That is the flag of \(countries[number])"
            flagTappedResult = false
        }
        
        if answerCount != 8 {
            showingScore = true
        } else {
            showingGrandResult = true
        }
        
        return flagTappedResult
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        answerCount = 0
        askQuestion()
    }
    
}

#Preview {
    ContentView()
}
