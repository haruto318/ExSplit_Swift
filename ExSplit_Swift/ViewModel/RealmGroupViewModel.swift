//
//  RealmUsersViewModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//
import Foundation
import RealmSwift

final class RealmGroupViewModel: ObservableObject {
    private(set) var realm: Realm?
    @Published var groups: [Group] = []
    
    init() {
        openRealm()
        getGroup()
    }

    // Realmとの接続を開くメソッド
    func openRealm() {
        let config = Realm.Configuration(
            schemaVersion: 2, // スキーマバージョンを2に更新
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // 必要ならば移行ロジックをここに記述
                    migration.enumerateObjects(ofType: Group.className()) { oldObject, newObject in
                        // 新しい balance プロパティを空のリストに初期化
                        newObject!["balance"] = List<Balance>()
                    }
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
        } catch {
            print("Realmを開く際のエラー", error)
        }
    }
    
    func addGroup(groupModel: GroupModel){
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
    
    
}
