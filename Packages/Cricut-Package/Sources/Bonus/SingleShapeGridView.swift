import SwiftUI


struct SingleShapeGridView: View {
  let items: [Item]

  let onDeleteAll: () -> Void
  let onAdd: () -> Void
  let onRemove: () -> Void

  var body: some View {
    VStack {
      ScrollView {
        ShapesGrid(items: items)
      }
      ButtonBarView(buttons: [
        .init(id: 1, title: "Delete All", action: onDeleteAll),
        .init(id: 2, title: "Add", action: onAdd),
        .init(id: 3, title: "Remove", action: onRemove),
      ])
    }
  }
}
