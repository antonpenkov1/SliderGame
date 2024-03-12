//
//  UISliderRepresentation.swift
//  SliderGame
//
//  Created by Антон Пеньков on 12.03.2024.
//

import SwiftUI

struct UISliderRepresentation: UIViewRepresentable {
    
    @Binding var currentValue: Double
    @Binding var opacity: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = Float(currentValue)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderMoved),
            for: .valueChanged
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = .red.withAlphaComponent(opacity)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $currentValue, opacity: $opacity)
    }
}

extension UISliderRepresentation {
    final class Coordinator: NSObject {
        @Binding var value: Double
        @Binding var opacity: Double
        
        init(value: Binding<Double>, opacity: Binding<Double>) {
            self._value = value
            self._opacity = opacity
        }
        
        @objc func sliderMoved(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

#Preview {
    UISliderRepresentation(currentValue: .constant(40), opacity: .constant(0.4))
}
