//
//  PaymentModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/07.
//

import Foundation
import SwiftUI

@Observable
final class PaymentModel {
    var purpose: String = ""
    var total: Double = 0.0
    var currency: Currency = Currency(code: "", name: "", japaneseName: "")
    var paidBy: Member = Member()
    var payments: [Int] = []
    
    func setPurpose(text: String) {
        purpose = text
    }
    
    func setTotal(amountText: String) {
        let parseAmount = amountText.components(separatedBy: " ")
        guard parseAmount.count == 2 else { return }
        if let parseTotal = Double(parseAmount[1]){
            total = parseTotal
        }
    }
    
    func resetTotal() {
        total = 0
    }

    func setCurrency(currency: Currency) {
        self.currency = currency
    }
    
    func setPaidBy(member: Member) {
        paidBy = member
    }
    
//    func addMember(name: String) {
//        members.append(name)
//    }
//    
//    func removeMember(index: String){
//        members.remove(at: members.firstIndex(of: index)!)
//    }
}

