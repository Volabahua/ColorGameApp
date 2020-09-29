//
//  ContentView.swift
//  ColorGame
//
//  Created by Владимир Лабахуа on 29.09.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var rTarget = Double.random(in: 0..<1)
    @State var gTarget = Double.random(in: 0..<1)
    @State var bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    @State var showAlert = false
    
    func randomize() {
        self.rTarget = Double.random(in: 0..<1)
        self.gTarget = Double.random(in: 0..<1)
        self.bTarget = Double.random(in: 0..<1)
    }
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
   @State var score = 0
   @State var level = 1
    
     func scoreUp(result: Int) {
        if result < 50 {
            score+=5
        } else if result>=50 && result<70 {
            score+=10
        } else if result>=70 && result<90 {
            score+=15
        } else if result>=90 && result<96 {
            score+=20
        } else if result>=96 {
            score+=30
        }
    }
    
     func lvlUp(){
        self.level+=1
    }
    
    // Создания экрана программы
    var body: some View {
        
        
        // Счет - цвета - кнопка - ползунки
        VStack {
            
            //Панель счета и уровней
            HStack {
                Text("Score: \(score)")
                    .padding(.trailing)
                
                Text("Level: \(level)")
                    .padding(.leading)
            }
            
            // Представление цветов
            HStack {
                // Target color block
                VStack {
                    Rectangle()
                      .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                  Text("Match this color")
                }
                // Guess color block
                VStack {
                    Rectangle()
                      .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    HStack(alignment: .center) {
                        Text("R: \(Int(rGuess * 255.0))")
                            
                        Text("G: \(Int(gGuess * 255.0))")
                            
                        Text("B: \(Int(bGuess * 255.0))")
                    }
                    
                }
                
            }
            .padding()
            
            // Кнопка проверки соответствия цвета
            Button(action: {self.showAlert = true}) {
              Text("Hit Me!")
            }
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Your score"), message: Text("Соответствие: \(computeScore())"), dismissButton: Alert.Button.default(Text("Next"), action: ({
                    scoreUp(result: computeScore())
                    randomize()
                    lvlUp()
                }) ))
                
//               Alert(title: Text("Your Score"), message: Text("Соответствие: \(computeScore())"))
            }
        }
            // Ползунки с указанием цвета
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
            
            
        }
    }

// Превью программы
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
                .previewDevice("iPhone 11 Pro Max")
        }
    }
}

// Универсальный ползунок для указания цвета
struct ColorSlider: View {
    
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }
        .padding()
    }
}
