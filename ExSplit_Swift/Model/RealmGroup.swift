//
//  RealmUsersModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import Foundation
import RealmSwift

final class Group: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var groupId: Int = 0
    @Persisted var members = List<Member>()
    @Persisted var groupName: String = ""
    @Persisted var homeCurrency: HomeCurrency!
}

final class HomeCurrency: EmbeddedObject {
    @Persisted var code: String = ""
    @Persisted var name: String = ""
    @Persisted var japaneseName = ""
}

final class Member: EmbeddedObject {
    @Persisted var memberId: Int = 0
    @Persisted var memberName: String = ""
    @Persisted var payments = List<Payment>()
}

final class Payment: EmbeddedObject {
    @Persisted var memberId: Int = 0
    @Persisted var amount: Double = 0.0
}




