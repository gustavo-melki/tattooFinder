import Foundation
import UIKit


class Tattooer {
  var _id = String()
  var address = String()
  var email = String()
  var latlng = String()
  var name = String()
  var phone = String()
  var picture = String()
  var shortAddress = String()
  
  
  init() {
    
  }
  
  init(address: String, email: String, latlng: String, name: String, phone: String, picture: String, shortAddress: String, _id: String) {
    self.address = address
    self.email = email
    self.latlng = latlng
    self.name = name
    self.phone = phone
    self.picture = picture
    self.shortAddress = shortAddress
    self._id = _id
  }
  
}
