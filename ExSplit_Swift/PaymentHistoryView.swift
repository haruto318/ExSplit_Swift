//
//  PaymentHistoryView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct PaymentHistoryView: View {
    // 仮
    @State var splits: [(id: Int, purpose: String, total: Int, paidBy: String)] = [(id: 1, purpose: "晩御飯", total: 10000, paidBy: "はると"), (id: 2, purpose: "朝ごはん", total: 10000, paidBy: "ゆーた"), (id: 2, purpose: "朝", total: 10000, paidBy: "ゆー")]

    var body: some View {
        
        VStack(spacing: 0) {
            
            /// title
            VStack {
                HStack(){
                    Text("すべての支払い")
                        .fontStyle(.titleBold)
                    Spacer()
                }
                Divider()
            }
            
            ScrollView(){
                Spacer().frame(height: 60)
                VStack(spacing: 10) {
                    
                    ForEach(Array(splits.reversed().enumerated()), id: \.offset){ offset, split in
                        /// 支払い
                        Button(action: {}) {
                            VStack(spacing: 5){
                                HStack(){
                                    Text(split.purpose)
                                        .fontStyle(.headBold)
                                        .foregroundColor(.customFontColor)
                                    Spacer()
                                    Button(action: {
                                        splits.remove(at: splits.count-1-offset)
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(Color.customFontColor)
                                    }
                                }
                                
                                HStack(){
                                    VStack(alignment: .leading, spacing: 0){
                                        Text("Amount").fontStyle(.description)
                                            .foregroundColor(.customFontColor)
                                        Text("\(split.total) yen").fontStyle(.body)
                                            .foregroundColor(.customFontColor)
                                    }
                                    Spacer()
                                    HStack(alignment: .center, spacing: 5){
                                        VStack(alignment: .trailing, spacing: 0){
                                            Text("Paid by").fontStyle(.description)
                                                .foregroundColor(.customFontColor)
                                            Text(split.paidBy).fontStyle(.body)
                                                .foregroundColor(.customFontColor)
                                        }
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.customFontColor)
                                    }
                                }
                            }.padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        }
                    }
                    
                    
                }.padding(.horizontal)
            }
            
            
            Spacer()
            
        }.padding()
        
    }
}

#Preview {
    PaymentHistoryView()
}


