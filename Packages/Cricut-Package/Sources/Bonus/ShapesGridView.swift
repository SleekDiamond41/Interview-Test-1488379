import Interface
import SwiftUI

struct ShapesGrid: View {
  let items: [Item]

  var body: some View {
    LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 200))]) {
      ForEach(items) {
        ShapeView(shape: $0.shape)
          .frame(width: 100, height: 100)
          .transition(.scale)
      }
    }
    .animation(.default, value: items.count)
  }
}
