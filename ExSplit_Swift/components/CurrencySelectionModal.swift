//
//  CurrencySelectionModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import SwiftUI

struct CurrencySelectionModal: View {
    private enum Regions: String, CaseIterable, Identifiable {
        case asia = "アジア"
        case oceania = "オセアニア"
        case europe = "ヨーロッパ"
        case america = "アメリカ"
        
        var regionData: [Currency] {
            switch self {
            case .asia:
                return asianCurrencies
            case .oceania:
                return oceanianCurrencies
            case .europe:
                return europeanCurrencies
            case .america:
                return americanCurrencies
            }
        }
            
        var id: String { rawValue }
    }
    
    @State private var selectedRegion = Regions.asia
    
    private var fruits = ["はると", "たけし", "こじろう"]
    @State var singleSelection: String?
    
    
    init() {
        // フォント属性を設定
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "ZenMaruGothic-Medium", size: 13.0)!
        ]
        
        // UISegmentedControlのタイトルテキスト属性を設定
        UISegmentedControl.appearance().setTitleTextAttributes(attr, for: .normal)
    }

    var body: some View {
        
        VStack(spacing: 40) {
            
            VStack(spacing: 40) {
                
                Text("通貨を選んでください")
                    .fontStyle(.title)
                
                /// segmented control
                VStack(spacing: 10){
                    Picker("periods", selection: $selectedRegion) {
                            ForEach(Regions.allCases) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                }
            
                ///通貨リスト
                List(selection: $singleSelection) {
                    ForEach(0..<selectedRegion.regionData.count, id: \.self) { index in
                        //.tagで指定した値をmultiSelectionに格納する
                        Text(selectedRegion.regionData[index].japaneseName)
                            .fontStyle(.headBold)
                            .tag(selectedRegion.regionData[index].code)
                    }
                }
                .scrollContentBackground(.hidden)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customFrameColor, lineWidth: 1)
                )
                .environment(\.editMode, .constant(.active))
                
            }.padding(.horizontal)
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    CurrencySelectionModal()
}
