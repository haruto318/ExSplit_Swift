//
//  GroupDetailView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/02.
//

import SwiftUI
struct GroupDetailView: View {
    let group: Group
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var realmViewModel = RealmGroupViewModel()
    
    @State private var isShowDeleteAlert: Bool = false
    @State private var isShowErrorAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            if let loadedGroup = realmViewModel.group {
                Text("Split").fontStyle(.titleBold)
                
                VStack(spacing: 40) {
                    VStack(spacing: 20){
                        /// グループ情報
                        VStack(spacing: 5){
                            HStack(){
                                Text(loadedGroup.groupName)
                                    .fontStyle(.headBoldJP)
                                Spacer()
                            }
                            VStack(spacing: 5){
                                HStack(){
                                    Text("通貨")
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customAccentColor)
                                    Spacer()
                                    Text(loadedGroup.homeCurrency.japaneseName)
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customFontColor)
                                }
                                HStack(){
                                    Text("参加人数")
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customAccentColor)
                                    Spacer()
                                    Text("\(loadedGroup.members.count)人")
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customFontColor)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customFrameColor, lineWidth: 1)
                        )
                        
                        /// メンバー
                        VStack(spacing: 5){
                            HStack(){
                                Text("メンバー")
                                    .fontStyle(.headBoldJP)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal){
                                HStack(spacing: 10){
                                    ForEach(loadedGroup.members, id: \.self) { member in
                                        VStack(spacing: 3){
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                            Text(member.memberName).fontStyle(.bodyJP)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            
                            Spacer().frame(height: 1)
                            
                            NavigationLink(destination: BalanceView(group: loadedGroup)) {
                                HStack {
                                    Spacer()
                                    Text("個別支払い状況を表示")
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.padding(12)
                                    .background(Color.customButtonColor)
                                    .cornerRadius(7)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }
                        }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                        
                        /// 直近の支払い
                        VStack(spacing: 5){
                            HStack(){
                                Text("直近の支払い")
                                    .fontStyle(.headBoldJP)
                                Spacer()
                            }
                            
                            VStack(spacing: 5){
                                if loadedGroup.balance.count != 0 {
                                    ForEach(Array(loadedGroup.balance.enumerated().prefix(3)), id: \.offset){ offset, split in
                                        Divider()
                                        HStack(){
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("Total Amount").fontStyle(.description)
                                                Text(loadedGroup.balance[loadedGroup.balance.count-1-offset].total, format: FloatingPointFormatStyle.Currency.currency(code: loadedGroup.homeCurrency.code)).fontStyle(.bodyJP)
                                            }
                                            Spacer()
                                            HStack(alignment: .center, spacing: 5){
                                                VStack(alignment: .trailing, spacing: 0){
                                                    Text("Paid by").fontStyle(.description)
                                                    Text(loadedGroup.balance[loadedGroup.balance.count-1-offset].paidBy.memberName).fontStyle(.bodyJP)
                                                }
                                                Image(systemName: "person.crop.circle")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                            }
                                        }
                                    }
                                } else {
                                    Divider()
                                    Text("支払いはありません").fontStyle(.bodyJP)
                                }
                            }
                            
                            Spacer().frame(height: 5)
                            
                            NavigationLink(destination: PaymentHistoryView(group: loadedGroup)){
                                HStack {
                                    Spacer()
                                    Text("すべて見る")
                                        .fontStyle(.bodyJP)
                                        .foregroundColor(Color.customFontColor)
                                    Spacer()
                                }.padding(12)
                                    .background(Color.customButtonColor)
                                    .cornerRadius(7)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customFrameColor, lineWidth: 1)
                                    )
                            }.disabled(loadedGroup.balance.isEmpty)
                        }.padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customFrameColor, lineWidth: 1)
                            )
                    }
                    
                    /// 支払い追加ボタン
                    VStack {
                        Spacer().frame(height: 20)
                        
                        NavigationLink(destination: AddPaymentView(group: loadedGroup)){
                            HStack {
                                Spacer()
                                Text("支払いを追加")
                                    .fontStyle(.headJP)
                                    .foregroundColor(Color.customFontColor)
                                Spacer()
                            }.padding()
                                .background(Color.customButtonColor)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.customFrameColor, lineWidth: 1)
                                ).padding(.horizontal, 10)
                        }
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
            } else {
                Text("グループ情報が読み込めませんでした。")
                    .fontStyle(.bodyJP)
            }
        }
        .padding()
        .onAppear{
            realmViewModel.getGroup(originGroup: group)
        }
        .navigationBarItems(trailing:
            Button(action: {
                isShowDeleteAlert = true
            }) {
                Image(systemName: "trash")
            }
            .alert("確認", isPresented: $isShowDeleteAlert) {
                Button("戻る", role: .cancel) {
                    isShowDeleteAlert = false
                }
                Button("削除する", role: .destructive) {
                    // Dismiss the view before deletion to prevent accessing invalidated objects
                    presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        // Delay the deletion slightly to ensure the view is dismissed
                        realmViewModel.deleteGroup(originGroup: group) { success in
                            if success {
                            } else {
                                isShowErrorAlert = true
                            }
                        }
                    }
                }
            } message: {
                Text("\(group.groupName)を削除しますか？")
            }
            .alert("Error", isPresented: $isShowErrorAlert) {
                Button("OK", role: .cancel) {
                    isShowErrorAlert = false
                }
            } message: {
                Text("正しく削除されませんでした")
            }
        )
    }
}


//#Preview {
//    GroupDetailView()
//}
