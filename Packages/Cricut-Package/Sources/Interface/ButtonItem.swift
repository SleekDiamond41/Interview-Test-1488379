import Foundation


public enum ItemShape: Sendable {
  case circle, square, triangle
}


public struct ButtonItem: Sendable {

  public var name: String
  public var shape: ItemShape

  public init(
    name: String,
    shape: ItemShape
  ) {
    self.name = name
    self.shape = shape
  }
}


extension ButtonItem {
  public static let mock = ButtonItem(
    name: "Roundy round",
    shape: .circle
  )
}
