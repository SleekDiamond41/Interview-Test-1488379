import Combine
import Foundation
import Testing

@testable import Core

@Suite
@MainActor
struct SingleShapeGridViewModelTests {
  @Test
  func name() async throws {
    // GIVEN: an empty input stream
    var onDeleteCalls = 0
    var onAddCalls = 0
    var onRemoveCalls = 0

    let viewModel = SingleShapeGridViewModel(
      Empty(),
      onDeleteAll: {
        onDeleteCalls += 1
      },
      onAdd: {
        onAddCalls += 1
      },
      onRemove: {
        onRemoveCalls += 1
      }
    )

    // THEN: bar on the bottom shows 3 buttons
    try #require(viewModel.buttonBarViewData.buttons.count == 3)

    // WHEN: "add" item is tapped
    viewModel.buttonBarViewData.buttons[1].action()
    viewModel.buttonBarViewData.buttons[1].action()

    // THEN: "add" item was tapped
    #expect(onAddCalls == 2)

    // WHEN: "remove" is tapped
    viewModel.buttonBarViewData.buttons[2].action()

    // THEN: "remove" was tapped
    #expect(onRemoveCalls == 1)

    // WHEN: "delete all" is tapped
    viewModel.buttonBarViewData.buttons[0].action()

    // THEN: "delete all" was tapped
    #expect(onDeleteCalls == 1)
  }
}
