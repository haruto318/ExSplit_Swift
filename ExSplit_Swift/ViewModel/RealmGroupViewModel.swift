//
//  RealmUsersViewModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import Combine
import RealmSwift

final class RealmGroupViewModel: ObservableObject {
    private var realm: Realm
    @Published var groups: Results<Group>
    private var notificationToken: NotificationToken?

    init(realm: Realm) {
        self.realm = realm
        self.groups = realm.objects(Group.self)
        
        // Realmのデータ変更を監視する
        notificationToken = groups.observe { [weak self] changes in
            switch changes {
            case .initial:
                // 初期データのセットアップ
                break
            case .update(_, let deletions, let insertions, let modifications):
                // データの変更に対応
                self?.objectWillChange.send()
            case .error(let error):
                // エラーハンドリング
                print(error.localizedDescription)
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func addUser(name: String) {
        let group = Group()
        group.groupName = name
        try? realm.write {
            realm.add(group)
        }
    }
}
