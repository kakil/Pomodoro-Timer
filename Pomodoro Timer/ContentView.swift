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
    
    let workTimeBackgroundColor = Color(red: 51/255, green: 59/255, blue: 78/255)
    let breakTimeBackgroundColor = Color(red: 133/255, green: 143/255, blue: 143/255, opacity: 1.0)
    //let breakTimeBackgroundColor = Color(red: 48/255, green: 57/255, blue: 75/255, opacity: 0.5)
    let lightGreyBackgroundColor = Color(red: 227/255, green: 225/255, blue: 222/255, opacity: 1.0)
    let lightGreyColor = Color(red: 227/255, green: 225/255, blue: 222/255, opacity: 1.0)
    let greenColor = Color(red: 7/255, green: 233/255, blue: 139/255, opacity: 1.0)
    let greyColor = Color(red: 139/255, green: 153/255, blue: 145/255, opacity: 1.0)
    let redColor = Color(red: 245/255, green: 81/255, blue: 81/255, opacity: 1.0)
    let blueGrey = Color(red: 148/255, green: 186/255, blue: 198/255, opacity: 1.0)
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func convertSecondsToTime(seconds: Int) -> String {
       
        let minutes = seconds / 60
        
        let secondsRemaining = seconds % 60
        return String(format: "%02i:%02i", minutes, secondsRemaining)
    }
    
    var backgroundColor: Color {
        return workTimeBackgroundColor
    }
    
    var textColor: Color {
        return lightGreyColor
    }
    
    var timerText: String {
        return timeToWork ? "Time To Work!" : "Break Time!"
    }
    
    var sliderProgress: Double {
        let totalTime = timeToWork ? workPeriodLength : breakPeriodLength
        let timeRemaining = timeToWork ? workTimeRemaining : breakTimeRemaining
        return Double(timeRemaining) / Double(totalTime) * 360.0
    }
    
    var sliderStrokeColor: Color {
        return timeToWork ? redColor : greenColor
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack (spacing: 30){
                Text("Pomodoro Timer")
                    .font(.system(size: 90))
                    .foregroundColor(textColor)
                Text("By AkilDev LLC")
                    .font(.system(size: 45))
                
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 1.0)
                        .stroke(greyColor, lineWidth: 10)
                        .frame(width: 300, height: 300)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(sliderProgress) / 360.0)
                        .stroke(sliderStrokeColor, lineWidth: 20)
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(-90))
                    Text(String(convertSecondsToTime(seconds: timeToShow)))
                        .font(.system(size: 80))
//                    Text("\(Int(sliderProgress))")
//                        .font(.system(size: 40))
//                        .foregroundColor(.white)
                            
                }
               
                Text(timerText)
                    .font(.system(size: 60))
                    .padding()
                
                ZStack {
                    Circle()
                        .foregroundColor(greenColor)
                        .frame(width: 120, height: 120)
                    Image(systemName: isPaused ? "play.fill" : "pause.fill" )
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(lightGreyColor)
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


