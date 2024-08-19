//
//  PaymentHistoryView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct PaymentHistoryView: View {
    let group: Group
    var balances: [Balance] = []
    
    init(group: Group) {
        self.group = group
        balances = Array(group.balance)
    }

    var body: some View {
        
        VStack(spacing: 0) {
            
            /// title
            VStack {
                HStack(){
                    Text("すべての支払い")
                        .fontStyle(.titleBoldJP)
                    Spacer()
                }
                Divider()
            }
            
            ScrollView(){
                Spacer().frame(height: 60)
                VStack(spacing: 10) {
                    
                    ForEach(Array(balances.reversed().enumerated()), id: \.offset){ offset, balance in
                        /// 支払い
                        NavigationLink(destination: PaymentDetailView(group: group, balance: balance)) {
                            VStack(spacing: 5){
                                HStack(){
                                    Text(balance.purpose)
                                        .fontStyle(.headBoldJP)
                                        .foregroundColor(.customFontColor)
                                    Spacer()
                                }
                                
                                HStack(){
                                    VStack(alignment: .leading, spacing: 0){
                                        Text("Amount").fontStyle(.description)
                                            .foregroundColor(.customFontColor)
                                        Text(balance.total, format: FloatingPointFormatStyle.Currency.currency(code: group.homeCurrency.code)).fontStyle(.body)
                                            .foregroundColor(.customFontColor)
                                    }
                                    Spacer()
                                    HStack(alignment: .center, spacing: 5){
                                        VStack(alignment: .trailing, spacing: 0){
                                            Text("Paid by").fontStyle(.description)
                                                .foregroundColor(.customFontColor)
                                            Text(balance.paidBy.memberName).fontStyle(.bodyJP)
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

//#Preview {
//    PaymentHistoryView()
//}


