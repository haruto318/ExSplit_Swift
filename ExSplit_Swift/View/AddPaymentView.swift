//
//  AddPaymentView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(PaymentModel.self) private var paymentModel
    @StateObject var currencyRatesViewModel: CurrencyRatesViewModel
    @ObservedObject var realmViewModel = RealmGroupViewModel()
    
    let group: Group
    
    @State var selectedMembers = Set<Int>()
    @State var membersPayment: [String] = []
    @State var selectedCurrency: Currency = Currency(code: "", name: "", japaneseName: "")

    @State var inputPurpose = ""
    @State var inputAmount: String = ""
    @State private var showSheet1 = false
    @State private var showSheet2 = false
    @State private var showSheet3 = false
    @State private var showAlert = false
    
    
    init(group: Group) {
        self.group = group
        _membersPayment = State(initialValue: Array(repeating: "", count: group.members.count))
        _currencyRatesViewModel = StateObject(wrappedValue: CurrencyRatesViewModel(homeCurrency: group.homeCurrency.code))
    }
    
    var selectedMembersNames: String {
        selectedMembers.map { group.members[$0].memberName }.joined(separator: " ")
    }
    
    var formatStyle: Decimal.FormatStyle.Currency {
        Decimal.FormatStyle.Currency
            .currency(code: paymentModel.currency.code == "" ? "JPY" : paymentModel.currency.code)
            .precision(.fractionLength(0))
            .locale(.init(identifier: "en_IN"))
    }
    
    // case split
    var isMembersPayment: Bool {
        let total = membersPayment.reduce(0) { (result, current) in
            let parseAmount = current.components(separatedBy: " ")
            guard parseAmount.count == 2, let parseTotal = Double(parseAmount[1]) else { return result }
            return result + parseTotal
        }
        return total > 0
    }
    
    // case splitEven
    var isSelectedMembers: Bool {
        return !selectedMembers.isEmpty
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
                                paymentModel.isEven = true
                                membersPayment = Array(repeating: "", count: group.members.count)
                            }) {
                                HStack {
                                    Spacer()
                                    Text("均等に分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(paymentModel.isEven ? Color.customButtonColor : .clear)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                            Button(action: {
                                paymentModel.isEven = false
                                membersPayment = Array(repeating: "", count: group.members.count)
                            }) {
                                HStack {
                                    Spacer()
                                    Text("割合分割")
                                        .fontStyle(.head)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.frame(height: 50)
                                .padding()
                                    .background(paymentModel.isEven ? .clear : Color.customButtonColor)
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
                            .onChange(of: inputPurpose) { newValue in
                                paymentModel.setPurpose(text: newValue)
                            }
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
                                    paymentModel.resetTotal()
                                    membersPayment = Array(repeating: "", count: group.members.count)
                                    inputAmount = ""
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
                    if paymentModel.isEven {
                        VStack(spacing: 10){
                            HStack {
                                Text("支払った金額")
                                    .fontStyle(.title)
                                Spacer()
                            }
                            TextField("支払った金額を入力してください", text: $inputAmount)
                                .keyboardType(.numberPad)
                                .font(.custom("ZenMaruGothic-Regular", size: 12))
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                )
                                .onChange(of: inputAmount) { newValue in
                                    if let parseAmount = try? formatStyle.parseStrategy.parse(newValue) {
                                        self.inputAmount = formatStyle.format(parseAmount)
                                    }
                                    paymentModel.setTotal(amountText: newValue)
                                }
                        }
                    }
                    
                    /// 誰に支払ったか or 各金額
                    if paymentModel.isEven {
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
                                ForEach(group.members, id: \.memberId){ member in
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
                                        TextField("金額を入力してください", text: $membersPayment[member.memberId])
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(TextAlignment.center)
                                            .font(.custom("ZenMaruGothic-Regular", size: 12))
                                            .padding()
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.customFrameColor, lineWidth: 1)
                                            )
                                            .onChange(of: membersPayment[member.memberId]) { newValue in
                                                if let parseAmount = try? formatStyle.parseStrategy.parse(newValue) {
                                                    self.membersPayment[member.memberId] = formatStyle.format(parseAmount)
                                                }
                                            }
                                    }
                                }

                            }
                        }
                    }
                    
                    /// 支払い追加ボタン
                    VStack {
                        Spacer().frame(height: 20)
                        Button(action: {
                            if let rate = currencyRatesViewModel.rates[paymentModel.currency.code], paymentModel.isEnabled {
                                let shouldAddPayment: Bool
                                
                                if paymentModel.isEven {
                                    shouldAddPayment = isSelectedMembers && inputAmount != ""
                                } else {
                                    shouldAddPayment = isMembersPayment
                                }
                                
                                if shouldAddPayment {
                                    realmViewModel.addPayment(group: group, paymentModel: paymentModel, selectedMembers: selectedMembers, membersPayment: membersPayment, rate: rate)
                                } else {
                                    showAlert = true
                                }
                            } else {
                                showAlert = true
                            }
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
}

//#Preview {
//    AddPaymentView()
//}

