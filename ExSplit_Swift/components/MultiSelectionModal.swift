//
//  MultiSelectionModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import SwiftUI

struct MultiSelectionModal: View {
    private var fruits = ["はると", "たけし", "こじろう"]
    @State var multiSelection = Set<Int>()
    
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
                            Text("全員")
                                .fontStyle(.headBold)
                                .foregroundColor(Color.customFontColor).animation(nil)
                        }
                    }
                    .disabled(true)
                    .onTapGesture {
                        isAll = !isAll
                        if isAll {
                            for i in fruits.indices {
                                multiSelection.insert(i)
                            }
                        } else {
                            for i in fruits.indices {
                                multiSelection.remove(i)
                            }
                        }
                      }
                }
                
                ///リスト
                List(selection: $multiSelection) {
                    ForEach(0..<fruits.count, id: \.self) { index in
                        //.tagで指定した値をmultiSelectionに格納する
                        Text(fruits[index])
                            .fontStyle(.headBold).tag(index)
                    }
                }
                .onChange(of: multiSelection, {
                    if multiSelection.count == fruits.count{
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

#Preview {
    MultiSelectionModal()
}
