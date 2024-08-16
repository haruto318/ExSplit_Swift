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
    case titleBoldJP
    case titleJP
    case headJP
    case headBoldJP
    case bodyJP
    case bodyBoldJP
    case descriptionJP
}

extension FontStyle {
    var dynamicType: SwiftUI.Font {
        switch self {
        case .titleBold:
            return .custom("Helvetica-Medium", size: 20)

        case .title:
            return .custom("Helvetica-Regular", size: 20)
            
        case .head:
            return .custom("Helvetica-Regular", size: 13)

        case .headBold:
            return .custom("Helvetica-Medium", size: 13)

        case .body:
            return .custom("Helvetica-Regular", size: 12)

        case .bodyBold:
            return .custom("Helvetica-Medium", size: 12)

        case .description:
            return .custom("Helvetica-Regular", size: 8)
         
        case .titleBoldJP:
            return .custom("ZenKakuGothicNew-Medium", size: 20)

        case .titleJP:
            return .custom("ZenKakuGothicNew-Regular", size: 20)
            
        case .headJP:
            return .custom("ZenKakuGothicNew-Regular", size: 13)

        case .headBoldJP:
            return .custom("ZenKakuGothicNew-Medium", size: 13)

        case .bodyJP:
            return .custom("ZenKakuGothicNew-Regular", size: 12)

        case .bodyBoldJP:
            return .custom("ZenKakuGothicNew-Medium", size: 12)

        case .descriptionJP:
            return .custom("ZenKakuGothicNew-Regular", size: 8)
        }
        
    }
}

extension Text {
    func fontStyle(_ style: FontStyle) -> some View {
        self.font(style.dynamicType)
    }
}
