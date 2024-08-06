//
//  NewGroupView.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/06.
//

import SwiftUI

struct NewGroupView: View {
    @State var inputName = ""
    @State private var showSheet = false
    @State var selection = 1
    @State var offset: CGFloat = .zero
    @State var isShowBackBtn: Bool = false
    @State var isShowNextBtn: Bool = true
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView(showsIndicators: false) {
                VStack {
                    if selection == 1 {
                        NewGroupSettingsView()
                    } else if selection == 2 {
                        AddGroupMembersView()
                    }
                }
                .animation(.easeInOut, value: selection)
            }
            
            navigationButtons
            
            Spacer()
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 50) {
            Spacer()
            
            backButton
            
            indicatorDots
            
            nextButton
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var backButton: some View {
        Button {
            backToPreviousPage()
            selection -= 1
        } label: {
            Image(systemName: "arrowtriangle.backward.fill")
                .font(.system(size: 50))
        }
        .disabled(!isShowBackBtn)
        .opacity(isShowBackBtn ? 1 : 0)
        .animation(.easeInOut, value: isShowBackBtn)
    }
    
    private var nextButton: some View {
        Button {
            goToNextPage()
            selection += 1
        } label: {
            Image(systemName: "arrowtriangle.forward.fill")
                .foregroundColor(Color.customAccentColor)
                .font(.system(size: 50))
        }
        .disabled(!isShowNextBtn)
        .opacity(isShowNextBtn ? 1 : 0)
        .animation(.easeInOut, value: isShowNextBtn)
    }
    
    private var indicatorDots: some View {
        HStack(spacing: 20) {
            ForEach(0..<2, id: \.self) { index in
                dotView(for: index)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func dotView(for index: Int) -> some View {
        Circle()
            .fill(index == selection - 1 ? Color.customAccentColor : Color.customFrameColor)
            .frame(width: 12, height: 12)
            .scaleEffect(index == selection - 1 ? 1.2 : 1)
            .animation(.easeInOut, value: selection)
    }

    
    func getIndex() -> Int {
        let process = offset / getScreenBounds().width
        return Int(process)
    }
    
    func goToNextPage() {
        let index = selection + 1
        updateButtonVisibility(for: index)
    }
    
    func backToPreviousPage() {
        let index = selection - 1
        updateButtonVisibility(for: index)
    }
    
    func updateButtonVisibility(for index: Int) {
        switch index {
        case 1:
            isShowBackBtn = false
            isShowNextBtn = true
        case 2:
            isShowNextBtn = false
            isShowBackBtn = true
        default:
            isShowBackBtn = true
            isShowNextBtn = true
        }
    }
}

#Preview {
    NewGroupView()
}
