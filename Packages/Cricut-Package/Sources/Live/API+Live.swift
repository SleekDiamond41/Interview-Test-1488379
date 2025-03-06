//
//  File.swift
//  Cricut-Package
//
//  Created by Michael Arrington on 3/3/25.
//

import Foundation
import Interface


public extension Dependencies {
  static let live = Dependencies(
    getButtons: {
      let url = URL(string: "http://staticcontent.cricut.com/static/test/shapes_001.json")!
      let (data, _) = try! await URLSession.shared.data(from: url)
      let result = try! JSONDecoder().decode(GetButtonsResponseDTO.self, from: data)

      return result.buttons.compactMap(ButtonItem.init)
    },
    uuid: {
      UUID()
    }
  )
}
struct GetButtonsResponseDTO: Decodable {
  let buttons: [ButtonItemDTO]
}

struct ButtonItemDTO: Decodable {
  let name: String
  let draw_path: String
}

extension ButtonItem {
  init?(_ item: ButtonItemDTO) {
    guard let shape = makeShape(item.draw_path) else {
      return nil
    }

    self.init(
      name: item.name,
      shape: shape
    )
  }
}

private func makeShape(_ str: String) -> ItemShape? {
  switch str {
  case "circle":
    .circle
  case "triangle":
    .triangle
  case "square":
    .square
  default:
    nil
  }
}
