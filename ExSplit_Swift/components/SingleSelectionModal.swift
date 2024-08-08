//
//  SelectionModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import SwiftUI
import RealmSwift

struct SingleSelectionModal: View {
    @Environment(PaymentModel.self) private var paymentModel
    
    let group: Group
    @State var selectMemberId: Int?
    var body: some View {
        
        VStack(spacing: 40) {
            
            VStack(spacing: 40) {
                
                Text("支払ったメンバーを選んでください")
                    .fontStyle(.title)
                
                List(selection: $selectMemberId) {
                    ForEach(0..<group.members.count, id: \.self) { index in
                        //.tagで指定した値をmultiSelectionに格納する
                        Text(group.members[index].memberName)
                            .fontStyle(.headBold).tag(group.members[index].memberId)
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
                .onChange(of: selectMemberId ?? 0) { oldValue, newValue in
                    paymentModel.setPaidBy(member: group.members[newValue])
                }
                
                
            
            }.padding(.horizontal)
            
            Spacer()
            
        }.padding()
    }
}

//#Preview {
//    SingleSelectionModal()
//}
