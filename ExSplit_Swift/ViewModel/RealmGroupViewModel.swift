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
    @Published var group: Group? = nil
    @Published var isActive: Bool = false

    init() {
        openRealm()
        getGroups()
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

    func addGroup(groupModel: GroupModel, completion: @escaping (Bool) -> Void) {
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
            completion(true)
        } else { completion(false) }
    }

    func getGroups() {
        if let realm = realm {
            let allGroups = realm.objects(Group.self)
            groups = []
            allGroups.forEach { group in
                groups.append(group)
            }
        }
    }
    
    func getGroup(originGroup: Group) {
        if let realm = realm {
            if let loadedGroup = realm.object(ofType: Group.self, forPrimaryKey: originGroup.groupId) {
                self.group = loadedGroup
            } else {
                print("Group not found in the database.")
            }
        }
    }
    
    func deleteGroup(originGroup: Group, completion: @escaping (Bool) -> Void) {
        guard let realm = realm else {
            completion(false)
            return
        }

        do {
            try realm.write {
                if let groupToDelete = realm.object(ofType: Group.self, forPrimaryKey: originGroup.groupId) {
                    // Delete the group and any related data
                    realm.delete(groupToDelete)
                    completion(true)
                } else {
                    print("Group not found in the database.")
                    completion(false)
                }
            }
        } catch {
            print("Error deleting group: \(error)")
            completion(false)
        }
    }




    
    func addPayment(group: Group, paymentModel: PaymentModel, selectedMembers: Set<Int>, membersPayment: [String], rate: Double, completion: @escaping (Bool) -> Void) {
        let balance = Balance()
        balance.purpose = paymentModel.purpose
        
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
        
        if paymentModel.isEven {
            splitEven(group: group, paymentModel: paymentModel, selectedMembers: selectedMembers, rate: rate, balance: balance) { success in
                success ? completion(true) : completion(false)
            }
        } else {
            split(group: group, paymentModel: paymentModel, membersPayment: membersPayment, rate: rate, balance: balance) { success in
                success ? completion(true) : completion(false)
            }
        }
    }
    
    func splitEven(group: Group, paymentModel: PaymentModel, selectedMembers: Set<Int>, rate: Double, balance: Balance, completion: @escaping (Bool) -> Void) {
        let convertedTotal = paymentModel.total / rate
        balance.total = convertedTotal + (convertedTotal * (paymentModel.chargePercent / 100))
        let perAmount = balance.total / Double(selectedMembers.count)
        
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
                completion(true)
            }catch {
                print("Error \(error)")
                completion(false)
            }
        } else { completion(false) }
    }
    
    func split(group: Group, paymentModel: PaymentModel, membersPayment: [String], rate: Double, balance: Balance, completion: @escaping (Bool) -> Void){
        
        let perAmounts = membersPayment.compactMap { payment -> Double? in
            let components = payment.components(separatedBy: " ")
            guard components.count == 2, let amount = Double(components[1]) else {
                return 0
            }
            return (amount / rate) + ((amount / rate) * (paymentModel.chargePercent / 100))
        }

        let total = perAmounts.reduce(0) { (result, current) in
            result + current
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
                completion(true)
            } catch {
                print("Error \(error)")
                completion(false)
            }
        } else { completion(false) }
    }
    
    
}
