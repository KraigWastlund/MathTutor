//
//  ContentView.swift
//  MathTutor
//
//  Created by Kraig Wastlund on 10/28/20.
//

import SwiftUI

struct GameView: View {
    
    var option: GameOption
    
    var body: some View {
        Text(option.type.title())
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

enum OptionType {
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
                    ForEach(options, id: \.self) { option in
                        NavigationLink(destination: GameView(option: option)) {
                            MainButton(title: option.type.title())
                        }
                        .padding(6)
                    }
                }
            }
        }
    }
}
