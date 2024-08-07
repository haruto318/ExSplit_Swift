//
//  ContentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/07/29.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var realmViewModel = RealmGroupViewModel()
    
    let splits = [(id: 1, name: "アジア", total: 10000, num: 4), (id: 2, name: "アジア", total: 10000, num: 4)]

    var body: some View {
        NavigationView {
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
                        /// 作成ボタン
                        NavigationLink(destination: NewGroupView()){
                            HStack {
                                Spacer()
                                Text("グループを生成する")
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
                    
                        Button(action: {
                            realmViewModel.getGroup()
                        }) {
                            HStack {
                                Spacer()
                                Text("グループを生成する")
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
                        
                        
                        VStack(spacing: 15){
                            HStack {
                                Text("Splits")
                                    .fontStyle(.titleBold)
                                Spacer()
                            }
                            
                            /// 仮リスト
                            ForEach(Array(realmViewModel.groups.enumerated()), id: \.offset){ offset, group in
                                
                                NavigationLink(destination: GroupDetailView(group: group)) {
                                    VStack(spacing: 5){
                                        HStack(){
                                            Text(group.groupName)
                                                .fontStyle(.headBold)
                                                .foregroundColor(.customFontColor)
                                            Spacer()
                                        }
                                        VStack(spacing: 5){
                                            HStack(){
                                                Text("通貨")
                                                    .fontStyle(.body)
                                                    .foregroundColor(Color.customAccentColor)
                                                Spacer()
                                                Text(group.homeCurrency.japaneseName)
                                                    .fontStyle(.body)
                                                    .foregroundColor(Color.customFontColor)
                                            }
                                            HStack(){
                                                Text("参加人数")
                                                    .fontStyle(.body)
                                                    .foregroundColor(Color.customAccentColor)
                                                Spacer()
                                                Text("\(group.members.count)人")
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
                                
                            }
                            
                        }
                        
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                }.padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
