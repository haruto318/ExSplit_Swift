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
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 40) {
                    
                    /// タイトル
                    VStack {
                        HStack(){
                            Text("Travellet")
                                .font(Font.custom("Helvetica-Medium", size: 24))
                            Spacer()
                        }
                        Divider()
                    }
                    
                    VStack(spacing: 40) {
                        /// 作成ボタン
                        NavigationLink(destination: NewGroupView()){
                            HStack {
                                Spacer()
                                Text("支払いグループを生成する")
                                    .fontStyle(.headJP)
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
                            
                            /// グループリスト
                            if realmViewModel.groups.isEmpty {
                                Text("グループを作成してみましょう！")
                                    .fontStyle(.headBoldJP)
                                    .foregroundColor(Color.customFontColor)
                                    .padding(20)
                            } else {
                                ForEach(Array(realmViewModel.groups.reversed().enumerated()), id: \.offset){ offset, group in
                                    
                                    NavigationLink(destination: GroupDetailView(group: group)) {
                                        VStack(spacing: 5){
                                            HStack(){
                                                Text(group.groupName)
                                                    .fontStyle(.headBoldJP)
                                                    .foregroundColor(.customFontColor)
                                                Spacer()
                                            }
                                            VStack(spacing: 5){
                                                HStack(){
                                                    Text("通貨")
                                                        .fontStyle(.bodyJP)
                                                        .foregroundColor(Color.customAccentColor)
                                                    Spacer()
                                                    Text(group.homeCurrency.japaneseName)
                                                        .fontStyle(.bodyJP)
                                                        .foregroundColor(Color.customFontColor)
                                                }
                                                HStack(){
                                                    Text("参加人数")
                                                        .fontStyle(.bodyJP)
                                                        .foregroundColor(Color.customAccentColor)
                                                    Spacer()
                                                    Text("\(group.members.count)人")
                                                        .fontStyle(.bodyJP)
                                                        .foregroundColor(Color.customFontColor)
                                                }
                                            }.padding(.horizontal)
                                        }
                                        .padding(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.customFrameColor, lineWidth: 1)
                                        )
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                }.padding()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    realmViewModel.getGroups()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
