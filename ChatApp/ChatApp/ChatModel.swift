//
//  ChatModel.swift
//  ChatApp
//
//  Created by jaewon Lee on 5/4/24.
//

import Foundation

struct Chat: Identifiable {
    var id: UUID { person.id }
    let person: Person
    var messages: [Message]
    var hasUnreadMessage = false
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
}

struct Message: Identifiable {
    
    enum MessageType {
        case Sent, Received
    }
    
    let id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date: Date) {
        self.date = date
        self.type = type
        self.text = text
    }
    
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}

extension Chat {
    static let sampleChat = [
        Chat(
            person: Person(name: "Hakim", imgString: "img1"),
            messages: [
                Message("Hey hakim", type: .Sent, date: Date(timeIntervalSince1970: 0)),
                Message("I'm just developing", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 30)),
                Message("Please I need your help🙂", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
                Message("Sure how can I help youflo?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
                Message("Maybe you send me mom \"good\" jokes", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
                Message("Sure I can do that. No problem.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
                Message("Sure I can do that. No problem.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
                Message("Sure I can do that. No problem.", type: .Received, date: Date())
            ],
            hasUnreadMessage: true
        ),
        Chat(
            person: Person(name: "JaeWon", imgString: "img3"),
            messages: [
                Message("Hey Jaewon", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 10)),
                Message("I'm just developing", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
                Message("Please I need your help🙂", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 9)),
                Message("Sure how can I help youflo?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 9)),
                Message("Maybe you send me mom \"good\" jokes", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
                Message("Sure I can do that. No problem.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1))
            ],
            hasUnreadMessage: true
        ),
        Chat(
            person: Person(name: "Joon", imgString: "img2"),
            messages: [
                Message("Hey Joon", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 5)),
                Message("I'm just developing", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 5)),
                Message("Please I need your help🙂", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 4)),
                Message("Sure how can I help youflo?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
                Message("Maybe you send me mom \"good\" jokes", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 2)),
                Message("Sure I can do that. No problem.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2))
            ],
            hasUnreadMessage: true
        )
    ]
}
