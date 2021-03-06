import Foundation

@testable import PetSearch

enum AccessTokenTestHelper {
  
  static func randomString() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    return String(letters.shuffled().prefix(8))
  }
  
  static func randomAPIToken() -> APIToken {
    APIToken(tokenType: "Bearer", expiresIn: 10, accessToken: randomString())
  }
  
  static func generateValidToken() -> String {
    """
    {
      "token_type": "Bearer",
      "expires_in": 10,
      "access_token": \"\(randomString())\"
    }
    """
  }
}

