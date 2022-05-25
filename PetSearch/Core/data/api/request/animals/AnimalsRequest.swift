enum AnimalsRequest: RequestProtocol {
  
  case getAnimalsWith(page: Int, lattitude: Double?, longitude: Double?)
  case getAnimalsBy(name: String, age: String?, type: String?)
  var path: String { "/v2/animals" }
  
  var urlParams: [String : String?] {
    switch self {
    case let .getAnimalsWith(page, lattitude, longitude):
      var params = ["page": String(page)]
      if let lattitude = lattitude {
        params["lattitude"] = String(lattitude)
      }
      if let longitude = longitude {
        params["longitude"] = String(longitude)
      }
      params["sort"] = "random"
      return params
      
    case let .getAnimalsBy(name, age, type):
      var params: [String: String] = [:]
      if !name.isEmpty {
        params["name"] = name
      }
      if let age = age {
        params["age"] = age
      }
      if let type = type {
        params["type"] = type
      }
      
      return params
    }
  }
  
  var requestType: RequestType { .GET }
  
}

