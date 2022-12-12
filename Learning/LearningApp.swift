//
//  LearningApp.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel: CardGameEmoji = CardGameEmoji()
            CardGameEmojiView(viewModel: viewModel)
        }
    }
}
