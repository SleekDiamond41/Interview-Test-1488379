import Testing

import Interface
@testable import Core

@Suite
@MainActor
struct ShapesGridViewModelTests {

  @Test
  func example() async throws {
    // GIVEN: a `getButtons` call that succeeds
    let viewModel = HomeViewModel(
      dependencies: using(.mock) {
        $0.getButtons = { @Sendable in
          [.init(name: "something", shape: .circle)]
        }
      }
    )

    // THEN: buttons start empty
    #expect(viewModel.buttonBarViewData.buttons.isEmpty)

    // WHEN: view model is on screen
    await viewModel.task()

    // THEN: a single shape button shows up
    #expect(viewModel.buttonBarViewData.buttons.map(\.title) == ["something"])

    // WHEN: our one button is tapped
    let item = try #require(viewModel.buttonBarViewData.buttons.first)
    item.action()

    // THEN: a circle was added
    #expect(viewModel.shapesGridViewData.items.map(\.shape) == [.circle])
  }
}
