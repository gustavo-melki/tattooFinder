import Foundation
import UIKit


class Tattoo {
  var id = String()
  var color = String()
  var name = String()
  var price = Double()
  var session = String()
  var size = String()
  var artistName = String()
  var upload = String()
  var urlImage = String()
  var enabled = Bool()
  var sold = Bool()
  var sold_url = String()
  
  init() {
    
  }
  
  init(id: String, color: String, name: String, price: Double, session: String, size: String, artistName: String, upload: String, urlImage: String, enabled: Bool, sold: Bool, sold_url: String) {
    self.id = id
    self.color = color
    self.name = name
    self.price = price
    self.session = session
    self.size = size
    self.artistName = artistName
    self.upload = upload
    self.urlImage = urlImage
    self.enabled = enabled
    self.sold = sold
    self.sold_url = sold_url
  }
  
}
