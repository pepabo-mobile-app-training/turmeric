
import Foundation

class CurrentUser {
    static var id: Int?
    static var name: String?
    static var email: String?
    static private var token: String?
    
    static func saveToken(token: String) {
        self.token = token
    }
    
    static func loadToken() -> String {
        return self.token!
    }
}
