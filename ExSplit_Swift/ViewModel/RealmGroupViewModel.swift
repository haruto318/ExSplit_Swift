//
//  RealmUsersViewModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//
import Foundation
import RealmSwift
import SwiftUI

final class RealmGroupViewModel: ObservableObject {
    private(set) var realm: Realm?
    @Published var groups: [Group] = []

    init() {
        openRealm()
        getGroup()
    }

    func openRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1
        )

        Realm.Configuration.defaultConfiguration = config

        do {
            realm = try Realm()
        } catch {
            print("Realmを開く際のエラー", error)
        }
    }

    func addGroup(groupModel: GroupModel) {
        let group = Group()
        group.groupName = groupModel.name

        let homeCurrency = HomeCurrency()
        homeCurrency.code = groupModel.homeCurrency.code
        homeCurrency.name = groupModel.homeCurrency.name
        homeCurrency.japaneseName = groupModel.homeCurrency.japaneseName
        group.homeCurrency = homeCurrency

        for (i, name) in zip(groupModel.members.indices, groupModel.members)  {
            let member = Member()
            member.memberId = i
            member.memberName = name
            for (j, _) in zip(groupModel.members.indices, groupModel.members) {
                let payment = Payment()
                payment.memberId = j
                payment.amount = 0
                member.payments.append(payment)
            }
            group.members.append(member)
        }

        if let realm = realm {
            try? realm.write({
                realm.add(group)
            })
            print(groups)
        }
    }

    func getGroup() {
        if let realm = realm {
            let allGroups = realm.objects(Group.self)
            groups = []
            allGroups.forEach { group in
                groups.append(group)
            }
            print(groups)
        }
    }

    
    func addPayment(group: Group, isEven: Bool, paymentModel: PaymentModel, selectedMembers: Set<Int>, membersPayment: [String], rate: Double) {
        let balance = Balance()
        balance.purpose = paymentModel.purpose
        balance.total = paymentModel.total / rate
        
        let member = Member()
        member.memberId = paymentModel.paidBy.memberId
        member.memberName = paymentModel.paidBy.memberName
        member.payments = List<Payment>()
        balance.paidBy = member
        
        let homeCurrency = HomeCurrency()
        homeCurrency.code = paymentModel.currency.code
        homeCurrency.name = paymentModel.currency.name
        homeCurrency.japaneseName = paymentModel.currency.japaneseName
        balance.currency = homeCurrency
        
        if isEven {
            splitEven(group: group, paymentModel: paymentModel, selectedMembers: selectedMembers, rate: rate, balance: balance)
        } else {
            split(group: group, paymentModel: paymentModel, membersPayment: membersPayment, rate: rate, balance: balance)
        }
    }
    
    func splitEven(group: Group, paymentModel: PaymentModel, selectedMembers: Set<Int>, rate: Double, balance: Balance) {
        let perAmount = paymentModel.total / rate / Double(selectedMembers.count)
        
        print("合計")
        print(balance.total)
        
        for (i, _) in zip(group.members.indices, group.members) {
            let payment = Payment()
            payment.memberId = i
            if selectedMembers.contains(i) {
                payment.amount = perAmount
            } else {
                payment.amount = 0
            }
            balance.payments.append(payment)
        }
        
        if let realm = realm {
            let fixedGroup = realm.object(ofType: Group.self, forPrimaryKey: group.groupId)
            do{
              try realm.write{
                  fixedGroup?.balance.append(balance)
                  selectedMembers.forEach { id in
                      fixedGroup?.members[paymentModel.paidBy.memberId].payments[id].amount += perAmount
                      fixedGroup?.members[id].payments[paymentModel.paidBy.memberId].amount -= perAmount
                  }
              }
            }catch {
              print("Error \(error)")
            }
        }
    }
    
    func split(group: Group, paymentModel: PaymentModel, membersPayment: [String], rate: Double, balance: Balance){
        let perAmounts = membersPayment.map { payment in
            Double(payment.components(separatedBy: " ")[1])! / rate
        }
        
        let total = perAmounts.reduce(0) { (result, current) in
            result + (current)
        }
        
        balance.total = total
        
        for (i, _) in zip(group.members.indices, group.members) {
            let payment = Payment()
            payment.memberId = i
            payment.amount = perAmounts[i]
            balance.payments.append(payment)
        }
        
        if let realm = realm {
            let fixedGroup = realm.object(ofType: Group.self, forPrimaryKey: group.groupId)
            do{
              try realm.write{
                  fixedGroup?.balance.append(balance)
                  for (i, _) in zip(group.members.indices, group.members) {
                      fixedGroup?.members[paymentModel.paidBy.memberId].payments[i].amount += perAmounts[i]
                      fixedGroup?.members[i].payments[paymentModel.paidBy.memberId].amount -= perAmounts[i]
                  }
              }
            }catch {
              print("Error \(error)")
            }
        }
    }
    
    
}
