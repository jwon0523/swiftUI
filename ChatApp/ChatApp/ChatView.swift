//
//  ChatView.swift
//  ChatApp
//
//  Created by jaewon Lee on 5/5/24.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewModel: ChatsViewModel
    
    let chat: Chat
    var body: some View {
        VStack(spacing: 0) {
            Text("Hello")
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.markAsUnread(false, chat: chat)
        }
    }
}

#Preview {
    ChatView(chat: Chat.sampleChat[0])
        .environmentObject(ChatsViewModel())
}
