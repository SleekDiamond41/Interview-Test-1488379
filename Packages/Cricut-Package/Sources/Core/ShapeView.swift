import Interface
import SwiftUI

struct ShapeView: View {
  let shape: ItemShape

  var body: some View {
    GeometryReader { geo in
      switch shape {
      case .circle:
        Circle()
      case .square:
        Rectangle()
      case .triangle:
        Path { path in
          let topTip = CGPoint(x: geo.size.width / 2, y: 0)
          let height = triangleHeight(base: geo.size.width)

          path.move(to: topTip)

          path.addLines([
            CGPoint(x: geo.size.width, y: height),
            CGPoint(x: 0, y: height),
            topTip,
          ])
        }
      }
    }
    .foregroundStyle(.teal)
  }

  func triangleHeight(base: CGFloat) -> CGFloat {
    base * 0.866
  }
}

#Preview("Triangle") {
  ShapeView(shape: .triangle)
}
