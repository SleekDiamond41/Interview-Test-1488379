import Foundation
import Testing

import Interface
import Live

@Suite
struct LiveTests {
  @Test func networkCallSucceeds() async {
    let buttons = await Dependencies.live.getButtons()
    print(UUID.mock(1))

    #expect(buttons.count == 3)
  }
}
