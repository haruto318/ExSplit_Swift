//
//  AddGroupMembersView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct AddGroupMembersView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(GroupModel.self) private var groupModel
    @ObservedObject var realmViewModel = RealmGroupViewModel()
        
    @State var inputName = ""
    @State private var showAlert: Bool = false
    
    let layout = [GridItem(.adaptive(minimum: 80, maximum: .infinity))]
    
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
                
                Text("メンバーを追加してください")
                    .fontStyle(.title)
                
                ///メンバー追加
                VStack(spacing: 10){
                    HStack {
                        Text("メンバー")
                            .fontStyle(.title)
                        Spacer()
                    }
                    HStack {
                        TextField("名前を入力してください", text: $inputName)
                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        
                        Button(action: {
                            groupModel.addMember(name: inputName)
                            inputName = ""
                        }) {
                            HStack {
                                Text("追加")
                                    .fontStyle(.body)
                                    .foregroundColor(Color.customFontColor)
                                    .padding(.horizontal, 5)
                            }.padding()
                                .background(Color.customButtonColor)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    }
                }
                
                ///メンバー表示
                GeometryReader { geometryProxy in
                    FlexibleView(
                        availableWidth: geometryProxy.size.width, 
                        data: groupModel.members,
                        spacing: 5,
                        alignment: .leading
                    ) { item in
                        HStack(spacing: 3) {
                            Text("\(item)").fontStyle(.body)
                            Button(action: {
                                groupModel.removeMember(index: item)
                            }) {
                                Text("×")
                                    .fontStyle(.bodyBold)
                                    .foregroundColor(.customFontColor)
                            }
                        }
                        .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.customButtonColor)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                ///グループ作成ボタン
                Button(action: {
                    if groupModel.isEnabled {
                        realmViewModel.addGroup(groupModel: groupModel) { success in
                            if success {
                                groupModel.resetGroup()
                                realmViewModel.getGroups()
                                inputName = ""
                                dismiss()
                            } else {
                                showAlert = true
                            }
                        }
                    } else {
                        showAlert = true
                    }
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
                    .sheet(isPresented: $showAlert) {
                        AlertModal()
                            .presentationDetents([
                                // 画面に対する割合
                                .fraction(0.4)
                            ])
                    }
            
            }.padding(.horizontal)
        
            
            Spacer()
            
            
        }.padding()
    }
}

//#Preview {
//    AddGroupMembersView()
//}
