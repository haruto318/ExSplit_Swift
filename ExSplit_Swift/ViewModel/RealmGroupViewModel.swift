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
            for (j, value) in zip(groupModel.members.indices, groupModel.members) {
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

    
    func addPayment(group: Group, isEven: Bool, paymentModel: PaymentModel, selectedMembers: Set<Int>, membersPayment: [Double]) {
        if isEven {
            splitEven(group: group, paymentModel: paymentModel, selectedMembers: selectedMembers)
        } else {
            split(group: group, paymentModel: paymentModel, membersPayment: membersPayment)
        }
    }
    
    func splitEven(group: Group, paymentModel: PaymentModel, selectedMembers: Set<Int>) {
        
    }
    
    func split(group: Group, paymentModel: PaymentModel, membersPayment: [Double]){
        
    }
    
    
}
