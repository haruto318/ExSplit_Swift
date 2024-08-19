//
//  FormatStyleExtension.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/17.
//

import Foundation

struct PercentFormatStyle: FormatStyle {
    typealias FormatInput = Double
    typealias FormatOutput = String

    var fractionLength: Int

    init(fractionLength: Int = 0) {
        self.fractionLength = fractionLength
    }

    func format(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = fractionLength
        numberFormatter.minimumFractionDigits = fractionLength
        return "\(numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)") ％"
    }

    static var `default`: PercentFormatStyle {
        return PercentFormatStyle(fractionLength: 1)
    }
}

extension FormatStyle where Self == PercentFormatStyle {
    static var percent: PercentFormatStyle {
        return .default
    }
}
