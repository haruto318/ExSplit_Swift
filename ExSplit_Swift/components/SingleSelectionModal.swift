//
//  SelectionModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import SwiftUI

struct SingleSelectionModal: View {
    private var fruits = ["はると", "たけし", "こじろう"]
    @State var singleSelection: Int?
    @State private var selectionValue = 3
    var body: some View {
        
        VStack(spacing: 40) {
            
            VStack(spacing: 40) {
                
                Text("支払ったメンバーを選んでください")
                    .fontStyle(.title)
                
                List(selection: $singleSelection) {
                    ForEach(0..<fruits.count, id: \.self) { index in
                        //.tagで指定した値をmultiSelectionに格納する
                        Text(fruits[index])
                            .fontStyle(.headBold).tag(index)
                    }
                }
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
    SingleSelectionModal()
}
