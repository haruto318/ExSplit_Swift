//
//  GroupDetailView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct GroupDetailView: View {
    // 仮
    let split = (id: 1, name: "アジア", total: 10000, num: 4)
    let members = ["はると", "こうたろ", "はると"]
    let splits: [(id: Int, total: Int, paidBy: String)] = [(id: 1, total: 10000, paidBy: "はると"), (id: 2, total: 10000, paidBy: "ゆーた"), (id: 2, total: 10000, paidBy: "ゆーた")]

    var body: some View {
        VStack(spacing: 40) {
            
            Text("Split").fontStyle(.titleBold)
            
            VStack(spacing: 40) {
                
                VStack(spacing: 20){
                    
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
                    
                    /// メンバー
                    VStack(spacing: 5){
                        HStack(){
                            Text("メンバー")
                                .fontStyle(.headBold)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal){
                            HStack(spacing: 10){
                                ForEach(members, id: \.self) { name in
                                    VStack(spacing: 3){
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        Text(name).fontStyle(.body)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        Spacer().frame(height: 1)
                        
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("個別支払い状況を表示")
                                    .fontStyle(.body)
                                    .foregroundColor(Color.customFontColor)
                                Spacer()
                            }.padding(12)
                                .background(Color.customButtonColor)
                                .cornerRadius(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    }.padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                    
                    /// 直近の支払い
                    VStack(spacing: 5){
                        HStack(){
                            Text("直近の支払い")
                                .fontStyle(.headBold)
                            Spacer()
                        }
                        
                        VStack(spacing: 5){
                            if splits.count != 0 {
                                ForEach(Array(splits.enumerated()), id: \.offset){ offset, split in
                                    Divider()
                                    HStack(){
                                        VStack(alignment: .leading, spacing: 0){
                                            Text("Total Amount").fontStyle(.description)
                                            Text("\(splits[splits.count-1-offset].total) yen").fontStyle(.body)
                                        }
                                        Spacer()
                                        HStack(alignment: .center, spacing: 5){
                                            VStack(alignment: .trailing, spacing: 0){
                                                Text("Paid by").fontStyle(.description)
                                                Text(splits[splits.count-1-offset].paidBy).fontStyle(.body)
                                            }
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                        
                                    }
                                }
                            } else {
                                Divider()
                                Text("支払いはありません").fontStyle(.body)
                            }
                        }
                        
                        Spacer().frame(height: 5)
                        
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("すべて見る")
                                    .fontStyle(.body)
                                    .foregroundColor(Color.customFontColor)
                                Spacer()
                            }.padding(12)
                                .background(Color.customButtonColor)
                                .cornerRadius(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    }.padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                }
                
                /// 支払い追加ボタン
                VStack {
                    Spacer().frame(height: 20)
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("支払いを追加")
                                .fontStyle(.head)
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
                }
                
            }.padding(.horizontal)
            
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    GroupDetailView()
}
