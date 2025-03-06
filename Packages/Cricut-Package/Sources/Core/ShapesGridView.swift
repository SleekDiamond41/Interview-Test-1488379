import Interface
import SwiftUI

struct ShapesGridViewData {
  struct Item: Identifiable {
    let id: Int
    let shape: ItemShape
  }

  let items: [Item]
}

struct ShapesGrid: View {
  let viewData: ShapesGridViewData

  var body: some View {
    LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 200))]) {
      ForEach(viewData.items) {
        ShapeView(shape: $0.shape)
          .frame(width: 100, height: 100)
          .transition(.scale)
      }
    }
    .animation(.bouncy, value: viewData.items.count)
  }
}
