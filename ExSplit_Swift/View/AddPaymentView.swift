//
//  AddPaymentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(PaymentModel.self) private var paymentModel
    let group: Group
    @State var selectedMembers = Set<Int>()
    @State var membersPayment: [Double] = []
    @State var selectedCurrency: Currency = Currency(code: "", name: "", japaneseName: "")
    // 仮
    @State var inputPurpose = ""
    @State var inputAmount: Double = 0
    @State var isEven: Bool = true
    @State private var showSheet1 = false
    @State private var showSheet2 = false
    @State private var showSheet3 = false
    
    init(group: Group) {
        self.group = group
        _membersPayment = State(initialValue: Array(repeating: 0, count: group.members.count))
        print(membersPayment)
    }
    
    var selectedMembersNames: String {
        selectedMembers.map { group.members[$0].memberName }.joined(separator: " ")
    }
    

    var body: some View {
        ScrollView(){
            VStack(spacing: 40) {
                
                /// title
                VStack {
                    HStack(){
                        Text("支払いを追加")
                            .fontStyle(.titleBold)
                        Spacer()
                    }
                    Divider()
                }
                
                
                VStack(spacing: 40) {
                    
                    ///支払い方法を選択
                    VStack(spacing: 10){
                        HStack {
                            Text("支払い方法を選択")
                                .fontStyle(.title)
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                isEven = true
                                membersPayment = Array(repeating: 0, count: group.members.count)
                            }) {
                                HStack {
                                    Spacer()
                                    Text("均等に分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(isEven ? Color.customButtonColor : .clear)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                            Button(action: {
                                isEven = false
                                membersPayment = Array(repeating: 0, count: group.members.count)
                            }) {
                                HStack {
                                    Spacer()
                                    Text("割合分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(isEven ? .clear : Color.customButtonColor)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    
                    /// 要件
                    VStack(spacing: 10){
                        HStack {
                            Text("要件")
                                .fontStyle(.title)
                            Spacer()
                        }
                        TextField("支払いの説明を入力してください", text: $inputPurpose)
                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }
                    
                    ///支払い通貨
                    VStack(spacing: 10){
                        HStack {
                            Text("支払い通貨")
                                .fontStyle(.title)
                            Spacer()
                        }
                        Button(action: {
                            showSheet3 = true
                        }){
                            HStack{
                                Text(paymentModel.currency.code == "" ? "通貨を選択してください" : paymentModel.currency.japaneseName)
                                    .font(.custom("ZenMaruGothic-Regular", size: 12))
                                    .foregroundStyle(paymentModel.currency.code == "" ? Color.customAccentColor : Color.customFontColor)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundStyle(Color.customAccentColor)

                            }
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        }.sheet(isPresented: $showSheet3) {
                            CurrencySelectionModal(selectedCurrency: $selectedCurrency)
                                .presentationDetents([
                                    // 画面に対する割合
                                    .fraction(0.8)
                                ])
                                .onDisappear{
                                    paymentModel.setCurrency(currency: selectedCurrency)
                                }
                        }
                    }
                    
                    ///支払った人
                    VStack(spacing: 10){
                        HStack {
                            Text("支払った人")
                                .fontStyle(.title)
                            Spacer()
                        }
                        
                        Button(action: {
                            showSheet1 = true
                        }){
                            HStack{
                                Text(paymentModel.paidBy.memberName == "" ? "支払った人を選択してください" : paymentModel.paidBy.memberName)
                                    .font(.custom("ZenMaruGothic-Regular", size: 12))
                                    .foregroundStyle(paymentModel.paidBy.memberName == "" ? Color.customAccentColor : Color.customFontColor)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundStyle(Color.customAccentColor)
                            }
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        }.sheet(isPresented: $showSheet1) {
                            SingleSelectionModal(group: group)
                                .presentationDetents([
                                    .fraction(0.8)
                                ])
                        }
                    }
                    
                    ///支払った金額
                    if isEven {
                        VStack(spacing: 10){
                            HStack {
                                Text("支払った金額")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            TextField("支払った金額を入力してください", value: $inputAmount, format: .currency(code: paymentModel.currency.code))
                                .keyboardType(.numberPad)
                                .font(.custom("ZenMaruGothic-Regular", size: 12))
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                        }
                    }
                    
                    /// 誰に支払ったか or 各金額
                    if isEven {
                        VStack(spacing: 10){
                            HStack {
                                Text("誰に支払ったか")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            Button(action: {
                                showSheet2 = true
                            }){
                                HStack{
                                    Text(selectedMembers.isEmpty ? "誰に支払ったかを選択してください" : selectedMembersNames)
                                        .font(.custom("ZenMaruGothic-Regular", size: 12))
                                        .foregroundStyle(selectedMembers.isEmpty ? Color.customAccentColor : Color.customFontColor)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundStyle(Color.customAccentColor)

                                }
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                            }.sheet(isPresented: $showSheet2) {
                                MultiSelectionModal(group: group, selectedMembers: $selectedMembers)
                                    .presentationDetents([
                                        // 画面に対する割合
                                        .fraction(0.8)
                                    ])
                            }
                        }
                    } else {
                        VStack(spacing: 10){
                            HStack {
                                Text("各金額")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            VStack(spacing: 5){
                                ForEach(group.members, id: \.self){ member in
                                    HStack {
                                        Text(member.memberName)
                                            .fontStyle(.body)
                                            .frame(width: 80)
                                            .padding()
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.customFrameColor, lineWidth: 1)
                                            )
                                        TextField("金額を入力してください", value: $membersPayment[member.memberId], format: .currency(code: paymentModel.currency.code))
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(TextAlignment.center)
                                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                                            .padding()
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.customFrameColor, lineWidth: 1)
                                            )
                                    }
                                }

                            }
                        }
                    }
                    
                    /// 支払い追加ボタン
                    VStack {
                        Spacer().frame(height: 20)
                        Button(action: {
                            
                        }) {
                            HStack {
                                Spacer()
                                Text("支払いを追加")
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
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                
            }.padding()
        }
    }
}

//#Preview {
//    AddPaymentView()
//}

