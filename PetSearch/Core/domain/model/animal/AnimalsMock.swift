import Foundation
private struct AnimalMock: Codable {
  let animals: [Animal]
}

private func loadAnimals() -> [Animal] {
  guard let url = Bundle.main.url(forResource: "AnimalsMock", withExtension: "json"),
        let data = try? Data(contentsOf: url) else { return [] }
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  do {
    let jsonMock = try decoder.decode(AnimalMock.self, from: data)
    return jsonMock.animals
  } catch { print(error.localizedDescription) }
  return []
}

extension Animal {
  static let mock = loadAnimals()
}
