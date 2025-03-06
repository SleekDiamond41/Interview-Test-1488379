import Foundation
import Interface


@MainActor
public final class HomeViewModel: ObservableObject {
  private struct Item {
    let id: UUID
    let shape: ItemShape
  }

  @Published private var _buttonItems: [ButtonItem] = []
  @Published private var _shapes: [Item] = []
  @Published private var _singleShapeGridViewModel: SingleShapeGridViewModel?

  private let dependencies: Dependencies

  public init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
}

// MARK: - View Interface
extension HomeViewModel {
  var buttonBarViewData: ButtonBarViewData {
    ButtonBarViewData(
      buttons: _buttonItems.map { item in
          .init(
            id: item.name.hashValue,
            title: item.name,
            action: {
              self.add(item.shape)
            }
          )
      }
    )
  }

  var shapesGridViewData: ShapesGridViewData {
    HomeViewModel.makeShapeGridViewData(_shapes)
  }

  var singleShapeGridViewModel: SingleShapeGridViewModel? {
    get { _singleShapeGridViewModel }
    set { _singleShapeGridViewModel = newValue }
  }

  func task() async {
    guard _buttonItems.isEmpty else {
      // don't download if we already finished once
      return
    }

    _buttonItems = await dependencies.getButtons()
  }

  func clearAllTapped() {
    _shapes.removeAll()
  }

  func editCircleTapped() {
    onEdit(.circle)
  }

  func editSquareTapped() {
    onEdit(.square)
  }

  func editTriangleTapped() {
    onEdit(.triangle)
  }
}

// MARK: - Helpers
private extension HomeViewModel {
  func add(_ shape: ItemShape) {
    _shapes.append(.init(id: UUID(), shape: shape))
  }

  func onEdit(_ shape: ItemShape) {
    _singleShapeGridViewModel = .init(
      $_shapes
        .map { $0.filter { $0.shape == shape } }
        .map(HomeViewModel.makeShapeGridViewData),
      onDeleteAll: { [weak self] in
        self?._shapes.removeAll { $0.shape == shape }
      },
      onAdd: { [weak self] in
        self?.add(shape)
      },
      onRemove: { [weak self] in
        guard let self,
              let index = self._shapes.lastIndex(where: { $0.shape == shape })
        else {
          return
        }

        self._shapes.remove(at: index)
      }
    )
  }

  private static func makeShapeGridViewData(_ shapes: [Item]) -> ShapesGridViewData {
    .init(
      items: shapes.map {
        .init(id: $0.id.hashValue, shape: $0.shape)
      }
    )
  }
}
