import Foundation


public struct Dependencies: Sendable {
  public var getButtons: @Sendable () async -> [ButtonItem]
  public var uuid: @Sendable () -> UUID

  public init(
    getButtons: @escaping @Sendable () async -> [ButtonItem],
    uuid: @escaping @Sendable () -> UUID
  ) {
    self.getButtons = getButtons
    self.uuid = uuid
  }
}


public extension Dependencies {
  static var mock: Dependencies {
    Dependencies(
      getButtons: {
        return [.mock]
      },
      uuid: {
        UUID.mock(1)
      }
    )
  }
}

public func using<T>(_ value: T, transform: (inout T) -> Void) -> T {
  var copy = value
  transform(&copy)
  return copy
}

extension UUID {
  public static func mock(_ int: UInt) -> UUID {
    unsafeBitCast((UInt(0), int), to: UUID.self)
  }
}
