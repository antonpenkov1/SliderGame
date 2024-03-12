//
//  ContentView.swift
//  SliderGame
//
//  Created by Антон Пеньков on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = Double.random(in: 0...100).rounded()
    @State private var showAlert = false
    
    @State private var opacity = 0.4
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Подвиньте слайдер как можно ближе к: \(targetValue.formatted())")
            HStack {
                Text("0")
                UISliderRepresentation(currentValue: $currentValue, opacity: $opacity)
                    .onChange(of: currentValue) { _, _ in
                        opacity = Double(computeScore())/100
                    }
                Text("100")
            }
            Button("Проверь меня!", action: checkValue)
                .alert("Your Score", isPresented: $showAlert, actions: {}) {
                    Text(computeScore().formatted())
                }
            Button("Начать заново", action: createNewValue)
        }
        .padding()
    }
    
    private func createNewValue() {
        targetValue = Int.random(in: 0...100)
        opacity = Double(computeScore())/100
    }
    
    private func checkValue() {
        showAlert.toggle()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}

#Preview {
    ContentView()
}
