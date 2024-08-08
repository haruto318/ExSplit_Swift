//
//  MultiSelectionModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import SwiftUI

struct MultiSelectionModal: View {
    let group: Group
    @Binding var selectedMembers: Set<Int>
    
    @State var isAll = false
    var body: some View {
        
        VStack(spacing: 40) {
            
            VStack(spacing: 40) {
                
                Text("支払うべきメンバーを選んでください")
                    .fontStyle(.title)
                
                VStack(spacing: 10){
                    ///全員ボタン
                    Button(action: {}){
                        HStack(){
                            Image(systemName: isAll ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(isAll ? Color.customAccentColor : Color.customFrameColor)
                            Text("全員で割り勘")
                                .fontStyle(.headBold)
                                .foregroundColor(Color.customFontColor).animation(nil)
                        }
                    }
                    .disabled(true)
                    .onTapGesture {
                        isAll = !isAll
                        if isAll {
                            for i in group.members.indices {
                                selectedMembers.insert(i)
                            }
                        } else {
                            for i in group.members.indices {
                                selectedMembers.remove(i)
                            }
                        }
                      }
                }
                
                ///リスト
                List(selection: $selectedMembers) {
                    ForEach(0..<group.members.count, id: \.self) { index in
                        //.tagで指定した値をmultiSelectionに格納する
                        Text(group.members[index].memberName)
                            .fontStyle(.headBold).tag(index)
                    }
                }
                .onChange(of: selectedMembers, {
                    if selectedMembers.count == group.members.count{
                        isAll = true
                    } else {
                        isAll = false
                    }
                })
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customFrameColor, lineWidth: 1)
                )
                //（参考：常に編集モードにする）
                .environment(\.editMode, .constant(.active))
                
                
            
            }.padding(.horizontal)
            
            Spacer()
            
        }.padding()
    }
}

//#Preview {
//    MultiSelectionModal()
//}
