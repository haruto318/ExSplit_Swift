//
//  NewGroupSettingsView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct NewGroupSettingsView: View {
    ///仮
    @State var inputName = ""
    @State private var showSheet = false
    
    var body: some View {
        VStack(spacing: 40) {
            
            /// title
            VStack {
                HStack(){
                    Text("グループを作成")
                        .fontStyle(.titleBold)
                    Spacer()
                }
                Divider()
            }
            
            VStack(spacing: 40) {
                
                Text("グループ名と基準通貨を入力してください")
                        .fontStyle(.title)
                
                VStack(spacing: 10){
                    HStack {
                        Text("グループ名")
                            .fontStyle(.title)
                        Spacer()
                    }
                    TextField("名前を入力してください", text: $inputName)
                        .font(.custom("ZenMaruGothic-Regular", size: 12))
                        .padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                    )
                }
                
                VStack(spacing: 10){
                    HStack {
                        Text("基準通貨")
                            .fontStyle(.title)
                        Spacer()
                    }
                    Button(action: {
                        showSheet = true
                    }){
                        HStack{
                            Text("通貨を選択してください")
                                .font(.custom("ZenMaruGothic-Regular", size: 12))
                                .foregroundStyle(Color.customAccentColor)
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
                        CurrencySelectionModal()
                            .presentationDetents([
                                // 画面に対する割合
                                .fraction(0.8)
                            ])
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
