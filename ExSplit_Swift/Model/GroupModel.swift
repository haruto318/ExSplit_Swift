//
//  NewGroup.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/06.
//

import SwiftUI
import Combine

@Observable
final class GroupModel {
    var name: String = ""
    var homeCurrency: String = ""
    var members: [String] = []
    
    func setName(text: String) {
        name = text
    }

    func setCurrency(currency: String) {
        homeCurrency = currency
    }
    
    func addMember(name: String) {
        members.append(name)
    }
    
    func removeMember(index: String){
        members.remove(at: members.firstIndex(of: index)!)
    }
}

