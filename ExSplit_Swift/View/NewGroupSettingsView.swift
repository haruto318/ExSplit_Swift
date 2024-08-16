//
//  NewGroupSettingsView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct NewGroupSettingsView: View {
    @Environment(GroupModel.self) private var groupModel

    @State private var inputName: String = ""
    @State private var showSheet = false

    @State private var selectedCurrency: Currency = Currency(code: "", name: "", japaneseName: "")
    
    var body: some View {
        VStack(spacing: 40) {
            
            /// title
            VStack {
                HStack(){
                    Text("グループを作成")
                        .fontStyle(.titleBoldJP)
                    Spacer()
                }
                Divider()
            }
            
            VStack(spacing: 40) {
                
                Text("グループ名と基準通貨を入力してください")
                        .fontStyle(.titleJP)
                
                /// グループ名
                VStack(spacing: 10){
                    HStack {
                        Text("グループ名")
                            .fontStyle(.titleJP)
                        Spacer()
                    }
                    TextField("名前を入力してください", text: $inputName)
                        .font(.custom("ZenKakuGothicNew-Regular", size: 12))
                        .padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                        .onChange(of: inputName) { newValue in
                            groupModel.setName(text: newValue)
                        }
                        .onAppear(perform: {
                            inputName = groupModel.name
                        })
                }
                
                /// 基準通貨
                VStack(spacing: 10){
                    HStack {
                        Text("基準通貨")
                            .fontStyle(.titleJP)
                        Spacer()
                    }
                    Button(action: {
                        showSheet = true
                    }){
                        HStack{
                            Text(groupModel.homeCurrency.code == "" ? "通貨を選択してください" : groupModel.homeCurrency.japaneseName)
                                .font(.custom("ZenKakuGothicNew-Regular", size: 12))
                                .foregroundStyle(groupModel.homeCurrency.code == "" ? Color.customAccentColor : Color.customFontColor)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundStyle(Color.customAccentColor)
                        }
                        .padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                    }.sheet(isPresented: $showSheet) {
                        CurrencySelectionModal(selectedCurrency: $selectedCurrency)
                            .presentationDetents([
                                // 画面に対する割合
                                .fraction(0.8)
                            ])
                            .onDisappear{
                                groupModel.setCurrency(currency: selectedCurrency)
                            }
                    }
                }

            }.padding(.horizontal)
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    NewGroupSettingsView()
}
