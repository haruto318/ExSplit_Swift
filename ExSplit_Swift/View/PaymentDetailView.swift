//
//  PaymentDetailView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct PaymentDetailView: View {
    // 仮
    let split = (id: 1, purpose: "晩御飯", total: 1000, memberNum: 4, paidBy: "はると", balance: [(name: "はると", amount: 0), (name: "ゆーた", amount: 500), (name: "りょう", amount: 500)])
    

    var body: some View {
        
        VStack(spacing: 40) {
            
            /// title
            Text(split.purpose)
                .fontStyle(.titleBold)
            
            VStack(spacing: 20) {
                
                /// 金額＆日付
                VStack(spacing: 5){
                    HStack(){
                        Text(split.purpose)
                            .fontStyle(.headBold)
                        Spacer()
                    }
                    VStack(spacing: 5){
                        HStack(){
                            Text("金額")
                                .fontStyle(.body)
                                .foregroundColor(Color.customAccentColor)
                            Spacer()
                            Text("\(split.total) yen")
                                .fontStyle(.body)
                                .foregroundColor(Color.customFontColor)
                        }
                        HStack(){
                            Text("日付")
                                .fontStyle(.body)
                                .foregroundColor(Color.customAccentColor)
                            Spacer()
                            Text("2024/03/24")
                                .fontStyle(.body)
                                .foregroundColor(Color.customFontColor)
                        }
                    }
                    .padding(.horizontal)
                }.padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customFrameColor, lineWidth: 1)
                    )
                
                /// 支払いの割合
                VStack(spacing: 5){
                    HStack(){
                        Text("支払いの割合")
                            .fontStyle(.headBold)
                        Spacer()
                    }
                    
                    VStack(spacing: 5){
                        ///個別
                        ForEach(Array(split.balance.enumerated()), id: \.offset){ offset, balance in
                            HStack(){
                                HStack(alignment: .center, spacing: 5){
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    VStack(alignment: .leading, spacing: 0){
                                        Text("Name").fontStyle(.description)
                                        Text(balance.name).fontStyle(.body)
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 0){
                                    Text("Cost").fontStyle(.description)
                                    Text("\(balance.amount) yen").fontStyle(.body)
                                }
                            }
                            Divider()
                        }
                        
                        ///total
                        HStack(){
                            Spacer()
                            VStack(alignment: .trailing, spacing: 0){
                                Text("Total").fontStyle(.description)
                                Text("\(split.total) yen").fontStyle(.bodyBold)
                            }
                        }
                    }
                    
                }.padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customFrameColor, lineWidth: 1)
                    )
                
            }.padding(.horizontal)
            
            
            Spacer()
            
        }.padding()
        
    }
}

#Preview {
    PaymentDetailView()
}


