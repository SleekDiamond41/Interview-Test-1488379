import Interface
import SwiftUI

struct Item: Identifiable {
  let id: UUID
  let shape: ItemShape
}

public struct HomeView: View {

  @State private var buttonItems: [ButtonItem] = []
  @State private var shapes: [Item] = []
  @State private var editingShape: ItemShape?

  let dependencies: Dependencies

  public init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }

  public var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          ShapesGrid(items: shapes)
        }

        ButtonBarView(
          buttons: buttonItems.map { button in
            .init(
              id: button.name.hashValue,
              title: button.name,
              action: {
                add(button.shape)
              }
            )
          }
        )
      }
      .navigationTitle("Bonus")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Clear All") {
            shapes.removeAll()
          }
        }

        ToolbarItem(placement: .primaryAction) {
          Button {
            editingShape = .circle
          } label: {
            Text("Edit Circles")
              .padding(.trailing, 4)
          }
          .contextMenu {
            Button("Edit Squares") {
              editingShape = .square
            }
            Button("Edit Triangles") {
              editingShape = .triangle
            }
          }
        }
      }
      .task {
        buttonItems = await dependencies.getButtons()
      }
      .navigationDestination(item: $editingShape) { shape in
        SingleShapeGridView(
          items: shapes.filter { $0.shape == shape },
          onDeleteAll: {
            removeAll(shape: shape)
          },
          onAdd: {
            add(shape)
          },
          onRemove: {
            removeLast(shape)
          }
        )
      }
    }
  }

  func removeAll(shape: ItemShape) {
    shapes.removeAll { $0.shape == shape }
  }

  func add(_ shape: ItemShape) {
    shapes.append(.init(id: UUID(), shape: shape))
  }

  func removeLast(_ shape: ItemShape) {
    guard let index = shapes.lastIndex(where: { $0.shape == shape }) else {
      return
    }

    shapes.remove(at: index)
  }
}

#Preview("Circles Only") {
  NavigationStack {
    HomeView(dependencies: .mock)
  }
}

#Preview("All Shapes") {
  let dependencies = using(Dependencies.mock) {
    $0.getButtons = {
      [
        .mock,
        .init(name: "Pointy", shape: .triangle),
        .init(name: "Blocky", shape: .square),
      ]
    }
  }

  NavigationStack {
    HomeView(dependencies: dependencies)
  }
}
