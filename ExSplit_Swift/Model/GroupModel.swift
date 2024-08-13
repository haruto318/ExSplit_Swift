//
//  NewGroup.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/06.
//

import SwiftUI

@Observable
final class GroupModel {
    var name: String = ""
    var homeCurrency: Currency = Currency(code: "", name: "", japaneseName: "")
    var members: [String] = []
    var isEnabled: Bool {
        return !(name == "" && homeCurrency.code == "" && members.count == 0)
    }
    
    func setName(text: String) {
        name = text
    }

    func setCurrency(currency: Currency) {
        homeCurrency = currency
    }
    
    func addMember(name: String) {
        members.append(name)
    }
    
    func removeMember(index: String){
        members.remove(at: members.firstIndex(of: index)!)
    }
}

