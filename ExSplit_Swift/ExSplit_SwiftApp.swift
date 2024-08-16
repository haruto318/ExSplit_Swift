//
//  ExSplit_SwiftApp.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/07/29.
//

import SwiftUI
import RealmSwift

@main
struct ExSplit_SwiftApp: SwiftUI.App {
    private let groupModel: GroupModel = .init()
    private let paymentModel: PaymentModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(groupModel).environment(paymentModel)
        }
    }
}
