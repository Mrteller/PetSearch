import XCTest
@testable import PetSearch

class AccessTokenManagerTests: XCTestCase {
  private var accessTokenManager: AccessTokenManagerProtocol?
  
  override func setUp() {
    super.setUp()
    guard let userDefaults = UserDefaults(suiteName: #file) else { return }
    
    userDefaults.removePersistentDomain(forName: #file)
    accessTokenManager = AccessTokenManager(userDefaults: userDefaults)
    let dummyToken = AccessTokenTestHelper.randomAPIToken()
    do {
      try accessTokenManager?.refreshWith(apiToken: dummyToken)
    } catch { XCTFail("Access token manager is probably nil") }
  }
  
  func testRequestToken() {
    guard let token = accessTokenManager?.fetchToken() else {
      XCTFail("Didn't get token from the access token manager")
      return
    }
    XCTAssertFalse(token.isEmpty, "Empty Token")
    print("Token = \(token)")
  }
  
  func testCachedToken() {
    guard let token = accessTokenManager?.fetchToken() else {
      XCTFail("Didn't get token from the access token manager")
      return
    }
    
    XCTAssertFalse(token.isEmpty)
    
  }
  
  func testRefreshToken() {
    guard let token = accessTokenManager?.fetchToken() else {
      XCTFail("Didn't get token from the access token manager")
      return
    }
    
    XCTAssertNoThrow(try accessTokenManager?.refreshWith(apiToken: AccessTokenTestHelper.randomAPIToken()), "Refresh token failed")
    
    guard let newToken = accessTokenManager?.fetchToken() else {
      XCTFail("Didn't get token from the access token manager")
      return
    }
    
    XCTAssertNotEqual(token, newToken)
    XCTAssertEqual(newToken, accessTokenManager?.fetchToken())
  }
  
  
}
