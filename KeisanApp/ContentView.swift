//
//  ContentView.swift
//  KeisanApp
//
//  Created by ヨシ on 2023/08/07.
//

import SwiftUI

struct UnitConverterView: View {
    @State private var inputValue: String = ""
    @State private var selectedUnit: ConversionType = .inchToMM
    @State private var isPickerPresented: Bool = false
    @State private var result: Double?
    
    enum ConversionType: String, CaseIterable {
        case inchToMM = "in → mm"
        case mmToInch = "mm → in"
        case nmToKM = "Nm → Km"
        case kmToNm = "Km → Nm"
        case inLbsToFtLbs = "in・lbs → ft・lbs"
        case ftlbsToInLbs = "ft・lbs → in・lbs"
    }
    
    var body: some View {
        ZStack {
            // 背景画像
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("計算アプリ")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .padding(.top, 20)
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    Text(selectedUnit.rawValue)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 200)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .actionSheet(isPresented: $isPickerPresented) {
                    ActionSheet(title: Text("単位を選択"), buttons: ConversionType.allCases.map { unitType in
                            .default(Text(unitType.rawValue)) {
                                selectedUnit = unitType
                            }
                    } + [.cancel()])
                }
                
                TextField("数値を入力してください", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 200)
                
                HStack(spacing: 20) {
                    Button {
                        convertUnits()
                    } label: {
                        Text("変換")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    Button {
                        resetValues()
                    } label: {
                        Text("リセット")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
                
                if let resultValue = result {
                    Text("結果: \(String(format: "%.2f", resultValue)) \(currentUnit())")
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding()
                        .frame(maxWidth: 300) // maxWidthを300に広げました
                }
                
                Spacer()
            }
            .padding(.top, 50)
        }
    }
        func resetValues() {
            inputValue = ""
            result = nil
        }
    func currentUnit() -> String {
        switch selectedUnit {
        case .inchToMM:
            return "mm"
        case .mmToInch:
            return "in"
        case .nmToKM:
            return "Km"
        case .kmToNm:
            return "Nm"
        case .inLbsToFtLbs:
            return "ft・lbs"
        case .ftlbsToInLbs:
            return "in・lbs"
        }
    }
        // 単位変換関数
        func convertUnits() {
            if let value = Double(inputValue) {
                switch selectedUnit {
                case .inchToMM:
                    result = value * 25.4
                case .mmToInch:
                    result = value / 25.4
                case .nmToKM:
                    result = value * 1.852
                case .kmToNm:
                    result = value / 1.852
                case .inLbsToFtLbs:
                    result = value / 12.0
                case .ftlbsToInLbs:
                    result = value * 12.0
                }
            }
        }
    }
    
    struct UnitConverterView_Previews: PreviewProvider {
        static var previews: some View {
            UnitConverterView()
        }
    }
