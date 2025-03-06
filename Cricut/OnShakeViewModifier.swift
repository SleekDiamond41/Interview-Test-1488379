//
//  OnShakeViewModifier.swift
//  Cricut
//
//  Created by Michael Arrington on 3/5/25.
//

import SwiftUI

/*
 Borrowed from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-shake-gestures
 */
extension View {
  func onShake(_ block: @escaping () -> Void) -> some View {
    self
      .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
        block()
      }
  }
}

private extension Notification.Name {
  static let deviceDidShakeNotification = Notification.Name("deviceDidShakeNotification")
}

extension UIWindow {
  open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      NotificationCenter.default.post(name: .deviceDidShakeNotification, object: nil)
    }
  }
}

