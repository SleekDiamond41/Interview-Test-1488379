//
//  CricutApp.swift
//  Cricut
//
//  Created by Michael Arrington on 3/3/25.
//

import Bonus
import Core
import Interface
import Live
import SwiftUI

@main
struct CricutApp: App {
  @StateObject private var homeViewModel = HomeViewModel(
    dependencies: .live
  )
  @State private var isShowingBonus = false

  var body: some Scene {
    WindowGroup {
      VStack {
        if isShowingBonus {
          Bonus.HomeView(dependencies: .live)
            .transition(.move(edge: .trailing))
        } else {
          Core.HomeView(viewModel: homeViewModel)
            .transition(.move(edge: .leading))
        }
      }
      .animation(.default, value: isShowingBonus)
      .onShake {
        isShowingBonus.toggle()
      }
    }
  }
}
