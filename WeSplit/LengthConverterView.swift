//
//  LengthConverterView.swift
//  WeSplit
//
//  Created by Luca Argentino on 26.11.23.
//

import SwiftUI

struct LengthConverterView: View {
    @State private var unit: Double = 0
    @State private var inputUnit = "mm"
    @State private var outputUnit = "km"
    @FocusState private var isInputUnitFocused: Bool
    
    private var lengthSpecificatoin = ["km", "m", "dm", "cm", "mm"]
    
    var unitConverter: Double {
        var outputMeasurement = Measurement(value: unit, unit: UnitLength.millimeters)
    
        switch inputUnit {
        case "km":
            outputMeasurement = Measurement(value: unit, unit: UnitLength.kilometers)
        case "m":
            outputMeasurement =  Measurement(value: unit, unit: UnitLength.meters)
        case "dm":
            outputMeasurement =  Measurement(value: unit, unit: UnitLength.decimeters)
        case "cm":
            outputMeasurement =  Measurement(value: unit, unit: UnitLength.centimeters)
        case "mm":
            outputMeasurement =  Measurement(value: unit, unit: UnitLength.millimeters)
        default:
            return unit
        }
        
        switch outputUnit {
        case "km":
            return outputMeasurement.converted(to: UnitLength.kilometers).value
        case "m":
                return outputMeasurement.converted(to: UnitLength.meters).value
        case "dm":
                return outputMeasurement.converted(to: UnitLength.decimeters).value
        case "cm":
            return outputMeasurement.converted(to: UnitLength.centimeters).value
        case "mm":
            return outputMeasurement.converted(to: UnitLength.millimeters).value
        default:
            return unit
        }
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Unit") {
                    Picker("Length", selection: $inputUnit) {
                        ForEach(Array(lengthSpecificatoin), id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output Unit") {
                    Picker("Length", selection: $outputUnit) {
                        ForEach(lengthSpecificatoin, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter Unit") {
                    TextField("Enter the desired length", value: $unit, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isInputUnitFocused)
                }
                
                Text(unitConverter.formatted())
            }
            .navigationTitle("Length convertion")
            .toolbar {
                Button("Done") {
                    if isInputUnitFocused {
                        isInputUnitFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    LengthConverterView()
}
