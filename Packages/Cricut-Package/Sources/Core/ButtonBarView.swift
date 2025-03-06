//
//  File.swift
//  Cricut-Package
//
//  Created by Michael Arrington on 3/3/25.
//

import SwiftUI

struct ButtonBarViewData {
  struct ButtonConfig: Identifiable {
    let id: Int
    let title: String
    let action: () -> Void
  }

  let buttons: [ButtonConfig]
}

struct ButtonBarView: View {
  let viewData: ButtonBarViewData

  var body: some View {
    HStack {
      ForEach(viewData.buttons) { config in
        Button(config.title, action: config.action)

        if config.id != viewData.buttons.last?.id {
          Spacer()
        }
      }
    }
    .padding()
  }
}
