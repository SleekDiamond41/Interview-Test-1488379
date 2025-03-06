import Combine
import SwiftUI


@MainActor
class SingleShapeGridViewModel: ObservableObject {
  @Published private var _items: ShapesGridViewData?

  private let onDeleteAll: () -> Void
  private let onAdd: () -> Void
  private let onRemove: () -> Void

  private var token: AnyCancellable?

  init(
    _ itemPublisher: some Publisher<ShapesGridViewData, Never>,
    onDeleteAll: @escaping () -> Void,
    onAdd: @escaping () -> Void,
    onRemove: @escaping () -> Void
  ) {
    self.onDeleteAll = onDeleteAll
    self.onAdd = onAdd
    self.onRemove = onRemove

    token = itemPublisher
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink { @MainActor [weak self] in
        self?._items = $0
      }
  }
}

// MARK: - View Interface
extension SingleShapeGridViewModel {
  var shapesGridViewData: ShapesGridViewData {
    _items ?? .init(items: [])
  }

  var buttonBarViewData: ButtonBarViewData {
    .init(
      buttons: [
        .init(id: 1, title: "Delete All", action: onDeleteAll),
        .init(id: 2, title: "Add", action: onAdd),
        .init(id: 3, title: "Remove", action: onRemove),
      ]
    )
  }
}
