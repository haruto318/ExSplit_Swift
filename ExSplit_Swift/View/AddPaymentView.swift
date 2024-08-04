//
//  AddPaymentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct AddPaymentView: View {
    // 仮
    @State var inputName = ""
    @State var isEven: Bool = true
    

    var body: some View {
        ScrollView(){
            VStack(spacing: 40) {
                
                /// title
                VStack {
                    HStack(){
                        Text("支払いを追加")
                            .fontStyle(.titleBold)
                        Spacer()
                    }
                    Divider()
                }
                
                
                VStack(spacing: 40) {
                    
                    ///支払い方法を選択
                    VStack(spacing: 10){
                        HStack {
                            Text("支払い方法を選択")
                                .fontStyle(.title)
                            Spacer()
                        }
                        HStack {
                            Button(action: {isEven = true}) {
                                HStack {
                                    Spacer()
                                    Text("均等に分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(isEven ? Color.customButtonColor : .clear)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                            Button(action: {isEven = false}) {
                                HStack {
                                    Spacer()
                                    Text("割合分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(isEven ? .clear : Color.customButtonColor)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    
                    /// 要件
                    VStack(spacing: 10){
                        HStack {
                            Text("要件")
                                .fontStyle(.title)
                            Spacer()
                        }
                        TextField("支払いの説明を入力してください", text: $inputName)
                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }
                    
                    ///支払い通貨
                    VStack(spacing: 10){
                        HStack {
                            Text("支払い通貨")
                                .fontStyle(.title)
                            Spacer()
                        }
                        TextField("通過を選択してください", text: $inputName)
                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }
                    
                    ///支払った人
                    VStack(spacing: 10){
                        HStack {
                            Text("支払った人")
                                .fontStyle(.title)
                            Spacer()
                        }
                        TextField("支払った人を選択してください", text: $inputName)
                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }
                    
                    ///支払った金額
                    if isEven {
                        VStack(spacing: 10){
                            HStack {
                                Text("支払った金額")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            TextField("支払った金額を入力してください", text: $inputName)
                                .font(.custom("ZenMaruGothic-Regular", size: 12))
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    }
                    
                    /// 誰に支払ったか or 各金額
                    if isEven {
                        VStack(spacing: 10){
                            HStack {
                                Text("誰に支払ったか")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            TextField("誰に支払ったかを選択してください", text: $inputName)
                                .font(.custom("ZenMaruGothic-Regular", size: 12))
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    } else {
                        VStack(spacing: 10){
                            HStack {
                                Text("各金額")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            VStack(spacing: 5){
                                HStack {
                                    Text("はると")
                                        .fontStyle(.body)
                                        .frame(width: 80)
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                    TextField("金額を入力してください", text: $inputName)
                                        .font(.custom("ZenMaruGothic-Regular", size: 12))
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                }
                                HStack {
                                    Text("はると")
                                        .fontStyle(.body)
                                        .frame(width: 80)
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                    TextField("金額を入力してください", text: $inputName)
                                        .font(.custom("ZenMaruGothic-Regular", size: 12))
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                }
                                HStack {
                                    Text("はると")
                                        .fontStyle(.body)
                                        .frame(width: 80)
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                    TextField("金額を入力してください", text: $inputName)
                                        .font(.custom("ZenMaruGothic-Regular", size: 12))
                                        .padding()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                }
                            }
                        }
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
}

#Preview {
    AddPaymentView()
}

