//
//  ContentView.swift
//  MathTutor
//
//  Created by Kraig Wastlund on 10/28/20.
//

import SwiftUI

struct GameView: View {
    
    var option: GameOption
    var difficulty: GameLevel
    
    var body: some View {
        Text(option.type.title())
        Text(difficulty.title())
    }
}

struct MainButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .light, design: .serif))
            .foregroundColor(.white)
            .frame(width: 180, height: 50)
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct AlertButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .light, design: .serif))
            .foregroundColor(.white)
            .frame(width: 80, height: 30)
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

enum OptionType: Equatable {
    case add
    case subtract
    case multiply
    case divide
    
    func title() -> String {
        switch self {
        case .add:
            return "add"
        case .subtract:
            return "subtract"
        case .multiply:
            return "multiply"
        case .divide:
            return "divide"
        }
    }
}

enum GameLevel {
    case easy
    case normal
    case hard
    
    func title() -> String {
        switch self {
        case .easy:
            return "easy"
        case .normal:
            return "normal"
        case .hard:
            return "hard"
        }
    }
}

struct GameOption: Hashable {
    let type: OptionType
    var level: GameLevel?
}

struct MainContentView: View {
    
    @State private var showAdd = false
    @State private var showSubtract = false
    @State private var showDivide = false
    @State private var showMultiply = false
    
    @State private var promptForDifficulty = false
    @State private var modeSelection: OptionType?
    
    @State private var difficultySelection: GameLevel? {
        didSet {
            guard let modeSelection = modeSelection else { return }
            switch modeSelection {
            case .add:
                showAdd.toggle()
            case .subtract:
                showSubtract.toggle()
            case .multiply:
                showMultiply.toggle()
            case .divide:
                showDivide.toggle()
            }
        }
    }
    
    private let options = [
        GameOption(type: .add),
        GameOption(type: .subtract),
        GameOption(type: .multiply),
        GameOption(type: .divide)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                VStack {
                    NavigationLink(destination: GameView(option: options[0], difficulty: difficultySelection ?? .easy), isActive: $showAdd) {}
                    Button(action: {
                        modeSelection = .add
                        promptForDifficulty.toggle()
                    }) {
                        MainButton(title: options[0].type.title())
                    }
                    .padding(6)
                    NavigationLink(destination: GameView(option: options[1], difficulty: difficultySelection ?? .easy), isActive: $showSubtract) {}
                    Button(action: {
                        modeSelection = .subtract
                        promptForDifficulty.toggle()
                    }) {
                        MainButton(title: options[1].type.title())
                    }
                    .padding(6)
                    NavigationLink(destination: GameView(option: options[2], difficulty: difficultySelection ?? .easy), isActive: $showMultiply) {}
                    Button(action: {
                        modeSelection = .multiply
                        promptForDifficulty.toggle()
                    }) {
                        MainButton(title: options[2].type.title())
                    }
                    .padding(6)
                    NavigationLink(destination: GameView(option: options[3], difficulty: difficultySelection ?? .easy), isActive: $showDivide) {}
                    Button(action: {
                        modeSelection = .divide
                        promptForDifficulty.toggle()
                    }) {
                        MainButton(title: options[3].type.title())
                    }
                    .padding(6)
                }
                
                if promptForDifficulty {
                    ZStack {
                        Color.blue
                            .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                            .shadow(color: Color.black, radius: 2)
                            .clipShape(Rectangle())
                        VStack {
                            Text("Choose Difficulty")
                                .foregroundColor(.white)
                                .padding(10)
                            HStack {
                                Button(action: {
                                    difficultySelection = .easy
                                    promptForDifficulty = false
                                }) {
                                    AlertButton(title: "Easy")
                                }
                                Button(action: {
                                    difficultySelection = .normal
                                    promptForDifficulty = false
                                }) {
                                    AlertButton(title: "Normal")
                                }
                                Button(action: {
                                    difficultySelection = .hard
                                    promptForDifficulty = false
                                }) {
                                    AlertButton(title: "Hard")
                                }
                            }
                        }
                    }
                    .frame(width: 300, height: 100)
                }
            }
        }
    }
}
