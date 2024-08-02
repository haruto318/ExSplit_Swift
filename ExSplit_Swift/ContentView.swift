//
//  ContentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/07/29.
//

import SwiftUI

struct ContentView: View {
    let splits = [(id: 1, name: "アジア", total: 10000, num: 4), (id: 2, name: "アジア", total: 10000, num: 4)]

    var body: some View {
        ScrollView{
            VStack(spacing: 40) {
                
                VStack {
                    HStack(){
                        Text("ExSplit")
                            .font(Font.custom("ZenMaruGothic-Medium", size: 24))
                        Spacer()
                    }
                    Divider()
                }
                
                VStack(spacing: 40) {
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("グループを生成する")
                                .fontStyle(.body)
                                .foregroundColor(Color.customFontColor)
                            Spacer()
                        }.padding()
                            .background(Color.customButtonColor)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }.padding(.horizontal, 10)
                    
                    
                    VStack(spacing: 15){
                        HStack {
                            Text("Splits")
                                .fontStyle(.titleBold)
                            Spacer()
                        }
                        
                        /// 仮リスト
                        ForEach(Array(splits.enumerated()), id: \.offset){ offset, split in
                            
                            VStack(spacing: 5){
                                HStack(){
                                    Text(split.name)
                                        .fontStyle(.headBold)
                                    Spacer()
                                }
                                VStack(spacing: 5){
                                    HStack(){
                                        Text("総金額")
                                            .fontStyle(.body)
                                            .foregroundColor(Color.customAccentColor)
                                        Spacer()
                                        Text("\(split.total) yen")
                                            .fontStyle(.body)
                                            .foregroundColor(Color.customFontColor)
                                    }
                                    HStack(){
                                        Text("参加人数")
                                            .fontStyle(.body)
                                            .foregroundColor(Color.customAccentColor)
                                        Spacer()
                                        Text("\(split.num)人")
                                            .fontStyle(.body)
                                            .foregroundColor(Color.customFontColor)
                                    }
                                }.padding(.horizontal)
                            }.padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                            
                        }
                        
                        /// 1 cell
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
                            }
                            .padding(.horizontal)
                        }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        
                        
                        
                        
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
