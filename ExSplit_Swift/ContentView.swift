//
//  ContentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/07/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(){
                Text("ExSplit")
                    .font(Font.custom("ZenMaruGothic-Medium", size: 24))
                Spacer()
            }
            Divider()
            
            Button(action: {}) {
                Text("グループを生成する")
                    .fontStyle(.titleBold)
            }
            
            VStack(){
                
                VStack(spacing: 5){
                    HStack(){
                        Text("東南アジア一周")
                            .fontStyle(.headBold)
                        Spacer()
                    }
                    VStack(spacing: 5){
                        HStack(){
                            Text("総金額")
                                .fontStyle(.body)
                                .foregroundColor(Color.customAccentColor)
                            Spacer()
                            Text("10,000 yen")
                                .fontStyle(.body)
                                .foregroundColor(Color.customFontColor)
                        }
                        HStack(){
                            Text("参加人数")
                                .fontStyle(.body)
                                .foregroundColor(Color.customAccentColor)
                            Spacer()
                            Text("4人")
                                .fontStyle(.body)
                                .foregroundColor(Color.customFontColor)
                        }
                    }.padding(.horizontal)
                }.padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customFrameColor, lineWidth: 1)
                    )
                
            }.padding(.horizontal)
            
        }
        .padding(.horizontal ,10)
        .padding()
    }
}

#Preview {
    ContentView()
}
