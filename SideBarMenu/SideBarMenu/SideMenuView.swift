//
//  SideMenuView.swift
//  SideBarMenu
//
//  Created by jaewon Lee on 7/25/24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedTag: Int
    @State private var selectedOption: SideMenuOptionModel?
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        SideMenuHeaderView()
                        
                        VStack {
                            ForEach(SideMenuOptionModel.allCases) { option in
                                Button(action: {
                                    onOptionTapped(option)
                                }, label: {
                                    SideMenuRowView(
                                        option: option,
                                        selectedOption: $selectedOption
                                    )
                                })
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
    
    private func onOptionTapped(_ option: SideMenuOptionModel) {
        selectedOption = option
        selectedTag = option.rawValue
        isShowing = false
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true), selectedTag: .constant(0))
}
