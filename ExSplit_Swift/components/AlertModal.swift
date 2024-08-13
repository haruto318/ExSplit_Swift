//
//  AlertModal.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/13.
//

import SwiftUI

struct AlertModal: View {

    var body: some View {
        
        VStack(spacing: 20) {
            Text("ボタンが正しく動作しません")
                .fontStyle(.titleBold)
            Text("全項目の入力をしてください")
                .fontStyle(.headBold)
                .foregroundColor(.red)
            
        }.padding()
    }
}

#Preview {
    AlertModal()
}
