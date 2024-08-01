//
//  TextExtension.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/01.
//

import Foundation
import SwiftUI

enum FontStyle: String, CaseIterable {
    case titleBold
    case title
    case head
    case headBold
    case body
    case bodyBold
    case description
}

extension FontStyle {
    var dynamicType: SwiftUI.Font {
        switch self {
        case .titleBold:
            return .custom("ZenMaruGothic-Medium", size: 20)

        case .title:
            return .custom("ZenMaruGothic-Regular", size: 20)
            
        case .head:
            return .custom("ZenMaruGothic-Regular", size: 13)

        case .headBold:
            return .custom("ZenMaruGothic-Medium", size: 13)

        case .body:
            return .custom("ZenMaruGothic-Regular", size: 12)

        case .bodyBold:
            return .custom("ZenMaruGothic-Medium", size: 12)

        case .description:
            return .custom("ZenMaruGothic-Regular", size: 8)
        }
    }
}

extension Text {
    func fontStyle(_ style: FontStyle) -> some View {
        self.font(style.dynamicType)
    }
}
