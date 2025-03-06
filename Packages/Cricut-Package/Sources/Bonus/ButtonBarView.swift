//
//  File.swift
//  Cricut-Package
//
//  Created by Michael Arrington on 3/3/25.
//

import SwiftUI

struct ButtonBarView: View {
  struct ButtonConfig: Identifiable {
    let id: Int
    let title: String
    let action: () -> Void
  }

  let buttons: [ButtonConfig]

  var body: some View {
    HStack {
      ForEach(buttons) { config in
        Button(config.title, action: config.action)

        if config.id != buttons.last?.id {
          Spacer()
        }
      }
    }
    .padding()
  }
}
