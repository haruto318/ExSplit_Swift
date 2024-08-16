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
    var chargePercent: Double = 0.0
    var isEven: Bool = true
    var isEnabled: Bool {
        return !(paidBy.memberName == "" && currency.code == "")
    }
    
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
    
    func resetPayment() {
        purpose = ""
        total = 0.0
        currency = Currency(code: "", name: "", japaneseName: "")
        paidBy = Member()
        isEven = true
    }
    
    func setChargePercent(percentText: String){
        let parsePercent = percentText.components(separatedBy: " ")
        guard parsePercent.count == 2 else { return }
        if let parseTotal = Double(parsePercent[0]){
            chargePercent = parseTotal
        }
    }
    
}

