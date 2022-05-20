import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
  let apiManager: any APIManagerProtocol
  let parser: any DataParserProtocol
  
  init(apiManager: APIManagerProtocol = APIManager(),
       parser: DataParserProtocol = DataParser()) {
    self.apiManager = apiManager
    self.parser = parser
  }
  
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    let authToken = try await requestAccessToken()
    let data = try await apiManager.perform(request, authToken: authToken)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }
  
  func requestAccessToken() async throws -> String {
    let data = try await apiManager.requestToken()
    let token: APIToken = try parser.parse(data: data)
    return token.bearerAccessToken
  }
}