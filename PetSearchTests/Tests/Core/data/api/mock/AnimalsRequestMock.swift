import Foundation
@testable import PetSearch

enum AnimalsRequestMock: RequestProtocol {
case getAnimalsBy
  
  var requestType: RequestType { .GET }
  
  var path: String {
    Bundle.main.path(forResource: "AnimalsMock", ofType: "json") ?? ""
  }

}
