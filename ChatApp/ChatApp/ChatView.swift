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
    
    @State private var text = ""
    @FocusState private var isFocused
    
    @State private var messageIdToScroll: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader(content: { reader in
                ScrollView {
                    ScrollViewReader { scrollReader in
                        getMessagesView(viewWidth: reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageIdToScroll) { _ in
                                if let  messageId = messageIdToScroll {
                                    scrollTo(messageID: messageId, shouldAnimate: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear {
                                if let messageID = chat.messages.last?.id {
                                    scrollTo(messageID: messageID, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                }
                            }
                    }
                }
            })
            .padding(.bottom, 5)
            
            tollbarView()
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
        .onAppear {
            viewModel.markAsUnread(false, chat: chat)
        }
    }
    
    var navBarLeadingBtn: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            HStack {
                Image(chat.person.imgString)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(chat.person.name).bold()
            }
            .foregroundColor(.black)
        })
    }
    
    var navBarTrailingBtn: some View {
        HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "video")
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "phone")
            })
        }
    }
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    func tollbarView() -> some View {
        VStack {
            let height: CGFloat = 37
            HStack {
                TextField("Message ...", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                
                Button(action: {
                    sendMessage()
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .background(
                            Circle()
                                .foregroundColor(text.isEmpty ? .gray : .blue)
                        )
                })
                .disabled(text.isEmpty)
            }
            .frame(height: height)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
    }
    
    func sendMessage() {
        if let message = viewModel.sendMessage(text, in: chat) {
            text = ""
            messageIdToScroll = message.id
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0, pinnedViews: [.sectionHeaders]) {
            let sectionMessages = viewModel.getDateSectionMessages(for: chat)
            ForEach(sectionMessages.indices, id: \.self) { sectionIndex in
                let messages = sectionMessages[sectionIndex]
                Section(header: sectionHeader(firstMessage: messages.first!)) {
                    ForEach(messages) { message in
                        let isReceived = message.type == .Received
                        HStack {
                            ZStack {
                                Text(message.text)
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(isReceived ? Color.black.opacity(0.2) : .green.opacity(0.9))
                                    .cornerRadius(13)
                            }
                            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing)
                            .padding(.vertical)
                            //                    .background(Color.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
                        .id(message.id) // important for automatic scrolling later
                    }
                }
                
            }
            
        }
    }
    
    func sectionHeader(firstMessage message: Message) -> some View {
        ZStack {
            Text(message.date.descriptiveString(dateStyle: .medium))
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .regular))
                .frame(width: 120)
                .padding(.vertical, 5)
                .background(Capsule().foregroundColor(.blue))
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationView {
        ChatView(chat: Chat.sampleChat[0])
            .environmentObject(ChatsViewModel())
    }
}

#Preview {
    ContentView()
}
