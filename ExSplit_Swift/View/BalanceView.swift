//
//  BalanceView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct BalanceView: View {
    let group: Group
    @State var currentMember = "0"
    
    var body: some View {
        VStack(spacing: 40) {
            /// ユーザー一覧＆選択
            VStack {
                ScrollView(.horizontal){
                    HStack(spacing: 10){
                        ForEach(group.members, id: \.memberId) { member in
                            Button(action: {
                                currentMember = "\(member.memberId)"
                            }){
                                VStack(spacing: 3){
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(currentMember == "\(member.memberId)" ? Color.customFontColor : Color.customAccentColor)
                                    Text(member.memberName)
                                        .fontStyle(.body)
                                        .foregroundColor(currentMember == "\(member.memberId)" ? Color.customFontColor : Color.customAccentColor)
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Divider()
            }
            
            VStack(spacing: 20) {
                
                if let member = group.members.first(where: { "\($0.memberId)" == currentMember }) {
                    let total = member.payments.reduce(0) { sum, payment in
                        sum + payment.amount
                    }
                    
                    /// ユーザー情報
                    VStack(spacing: 5){
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading, spacing: 0){
                                Text(member.memberName).fontStyle(.headBold)
                                HStack(spacing: 5){
                                    Text(abs(total), format: FloatingPointFormatStyle.Currency.currency(code: group.homeCurrency.code))
                                        .fontStyle(.body)
                                        .foregroundColor(total < 0 ? .red : .green)
                                    Text("\(total < 0 ? "借り" : "貸し")あり")
                                        .fontStyle(.body)
                                        .foregroundColor(total < 0 ? .red : .green)
                                }
                            }
                            Spacer()
                        }
                        
                    }.padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                    
                    /// 借りフィルター
                    let negativeBalances = member.payments.filter { $0.amount < 0 }
                    /// 貸しフィルター
                    let positiveBalances = member.payments.filter { $0.amount > 0 }
                    
                    /// 借り一覧
                    if !negativeBalances.isEmpty {
                        VStack(spacing: 10){
                            HStack(){
                                Text("借り")
                                    .fontStyle(.headBold)
                                Spacer()
                            }
                            VStack(spacing: 5){
                                ForEach(Array(negativeBalances), id: \.memberId){ balance in
                                    Divider()
                                    HStack(){
                                        HStack(alignment: .center, spacing: 5){
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("Name").fontStyle(.description)
                                                Text(group.members.first(where: { $0.memberId == balance.memberId })!.memberName).fontStyle(.body)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "arrow.left")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundColor(.red)
                                        Spacer()
                                        VStack(alignment: .trailing, spacing: 0){
                                            Text("Cost").fontStyle(.description)
                                            Text(abs(balance.amount), format: FloatingPointFormatStyle.Currency.currency(code: group.homeCurrency.code))
                                                .fontStyle(.body)
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }

                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                    }
                    
                    /// 貸し一覧
                    if !positiveBalances.isEmpty {
                        VStack(spacing: 10){
                            HStack(){
                                Text("貸し")
                                    .fontStyle(.headBold)
                                Spacer()
                            }
                            VStack(spacing: 5){
                                ForEach(Array(positiveBalances), id: \.memberId){ balance in
                                    Divider()
                                    HStack(){
                                        HStack(alignment: .center, spacing: 5){
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("Name")
                                                    .fontStyle(.description)
                                                Text(group.members.first(where: { $0.memberId == balance.memberId })!.memberName)
                                                    .fontStyle(.body)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundColor(.green)
                                        Spacer()
                                        VStack(alignment: .trailing, spacing: 0){
                                            Text("Cost")
                                                .fontStyle(.description)
                                            Text(abs(balance.amount), format: FloatingPointFormatStyle.Currency.currency(code: group.homeCurrency.code))
                                                .fontStyle(.body)
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                            }

                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                    }
                }
                
                


            
            }.padding(.horizontal)
            
            Spacer()
            
        }.padding()
    }
}

//#Preview {
//    BalanceView()
//}
