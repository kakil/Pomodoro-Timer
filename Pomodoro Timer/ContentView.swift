//
//  ContentView.swift
//  Pomodoro Timer
//
//  Created by Kitwana Akil on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var timeToShow = 0
    @State var workTimeRemaining = 1500
    @State var breakTimeRemaining = 300
    @State var timeToWork = true
    @State var isPaused = true
    
    let workPeriodLength = 1500
    let breakPeriodLength = 300
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func convertSecondsToTime(seconds: Int) -> String {
       
        let minutes = seconds / 60
        
        let secondsRemaining = seconds % 60
        return String(format: "%02i:%02i", minutes, secondsRemaining)
    }
    
    var backgroundColor: Color {
        return timeToWork ? Color.black : Color.white
    }
    
    var textColor: Color {
        return timeToWork ? Color.white : Color.black
    }
    
    var timerText: String {
        return timeToWork ? "Time To Work!" : "Break Time!"
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack (spacing: 30){
                Text("Pomodoro Timer")
                    .font(.system(size: 90))
                Text("By AkilDev LLC")
                    .font(.system(size: 45))
                Text(String(convertSecondsToTime(seconds: timeToShow)))
                    .font(.system(size: 80))
                Text(timerText)
                    .font(.system(size: 60))
                    .padding()
                ZStack {
                    Circle()
                        .foregroundColor(Color.blue)
                        .frame(width: 120, height: 120)
                    Image(systemName: isPaused ? "play.fill" : "pause.fill" )
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                            
                }
                .onTapGesture {
                    isPaused.toggle()
                }
                    
            }
            .padding()
            .foregroundColor(textColor)
            .onReceive(timer, perform: { _ in
                if !isPaused {
                    if (timeToWork) {
                        
                        if (workTimeRemaining >= 0) {
                            timeToShow = workTimeRemaining
                            workTimeRemaining -= 1
                        } else {
                            timeToWork = false
                            workTimeRemaining = workPeriodLength
                        }
                        
                    } else {
                        
                        if (breakTimeRemaining >= 0) {
                            timeToShow = breakTimeRemaining
                            breakTimeRemaining -= 1
                        } else {
                            timeToWork = true
                            breakTimeRemaining = breakPeriodLength
                            
                        }
                    }
                }
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
