struct AnimalContainer: Decodable {
  let animals: [Animal]
  let pagination: Pagination
}
