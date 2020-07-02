//
//  ContentView.swift
//  mini-app
//
//  Created by Maxime Britto on 24/06/2020.
//

import SwiftUI

struct ContentView: View {
    @State var score:Int = 0
    
    var buttonColor:Color {
        let color:Color
        switch score {
        case 0..<10:
            color = .black
        case 10..<20:
            color = .orange
        default:
            color = .red
        }
        return color
    }
    
    @State var secondsLeft:Int = 0
    
    var body: some View {
        VStack {
            
            HStack {
                if score > 30 {
                    Image(systemName: "flame")
                        .font(.title)
                }
                Text("Score : \(score)")
                    .padding()
            }
            if secondsLeft > 0 {
                Text("Temps restant : \(secondsLeft)s")
                Image(systemName: "plus.square")
                    .font(.largeTitle)
                    .onTapGesture {
                        score += 1
                    }
            } else {
                Spacer()
                Button("Nouvelle partie") {
                    startNewGame()
                }
            }
        }
        .foregroundColor(buttonColor)
    }
    
    func startNewGame() {
        score = 0
        secondsLeft = 10
        let endTime = Date(timeIntervalSinceNow: TimeInterval(secondsLeft))
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            var interval = endTime.timeIntervalSince1970 - Date().timeIntervalSince1970
            if interval < 0 {
                interval = 0
                timer.invalidate()
            }
            secondsLeft = Int(interval)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
