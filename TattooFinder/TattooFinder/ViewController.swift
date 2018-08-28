//
//  ViewController.swift
//  TattooFinder
//
//  Created by Gustavo Melki Leal on 27/08/2018.
//  Copyright © 2018 Gustavo Melki Leal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CenteredCollectionView
import SDWebImage


class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tattooImageView: UIImageView!
  
  
  var tattoos = [Tattoo]()
  var tattooer = Tattooer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    
    let ref = Database.database().reference().child("Tattoo")
    ref.queryOrdered(byChild: "enabled").queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
      
      print(snapshot)
      let tattoos = snapshot.value as! [String : AnyObject]
      for tattoo in tattoos {
        
        let id = tattoo.key
        guard let color = tattoo.value["color"] as? String else {return}
        guard let name = tattoo.value["name"] as? String else {return}
        guard let price = tattoo.value["price"] as? Double else {return}
        guard let session = tattoo.value["session"] as? String else {return}
        guard let size = tattoo.value["size"] as? String else {return}
        guard let artist = tattoo.value["tattooer"] as? String else {return}
        guard let upload = tattoo.value["upload"] as? String else {return}
        guard let url = tattoo.value["url"] as? String else {return}
        guard let sold = tattoo.value["sold"] as? Bool else {return}
        guard let enabled = tattoo.value["enabled"] as? Bool else {return}
        guard let sold_url = tattoo.value["sold_url"] as? String else {return}
        
        let tattoo = Tattoo.init(id: id, color: color, name: name, price: price, session: session, size: size, artistName: artist, upload: upload, urlImage: url, enabled: enabled, sold: sold, sold_url: sold_url)
        self.tattoos.append(tattoo)
      }
      
      self.collectionView.reloadData()
      
      if self.tattooImageView.image == nil {
        
        UIView.transition(with: self.tattooImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {self.tattooImageView.sd_setImage(with: URL(string: self.tattoos[0].urlImage))},
                          completion: nil)
      }
    }, withCancel: { (error) in
      
      
    })
  }
  
  func setupCollectionView(){
    
    // The width of each cell with respect to the screen.
    // Can be a constant or a percentage.
    let cellPercentWidth: CGFloat = 1
    
    // A reference to the `CenteredCollectionViewFlowLayout`.
    // Must be aquired from the IBOutlet collectionView.
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    // Get the reference to the `CenteredCollectionViewFlowLayout` (REQURED STEP)
    centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout
    
    // Modify the collectionView's decelerationRate (REQURED STEP)
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    
    // Configure the required item size (REQURED STEP)
    centeredCollectionViewFlowLayout.itemSize = CGSize(
      width: view.bounds.width * cellPercentWidth,
      height: view.bounds.height * cellPercentWidth * cellPercentWidth
    )
    
    // Assign delegate and data source
    //    collectionView.delegate = self
    //    collectionView.dataSource = self
    
    // Configure the optional inter item spacing (OPTIONAL STEP)
    centeredCollectionViewFlowLayout.minimumLineSpacing = 0
    
    // Get rid of scrolling indicators
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
  }
  
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print(tattoos.count)
    return tattoos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TattooerCollectionViewCell
    
    let refTattoer = Database.database().reference().child("Tattoer")
    refTattoer.child(self.tattoos[indexPath.item].artistName).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
      guard let tattooer = snapshot.value as? [String : AnyObject] else {return}
      guard let name = tattooer["name"] as? String else { return }
      guard let address = tattooer["address"] as? String else { return }
      guard let email = tattooer["email"] as? String else { return }
      guard let latlng = tattooer["latlng"] as? String else { return }
      guard let phone = tattooer["phone"] as? String else { return }
      guard let shortAddress = tattooer["shortAddress"] as? String else { return }
      guard let picture = tattooer["picture"] as? String else { return }
      let id = snapshot.key
      
      self.tattooer = Tattooer(address: address, email: email, latlng: latlng, name: name, phone: phone, picture: picture, shortAddress: shortAddress, _id: id)
      
      print(self.tattooer.name)
      cell.artistName.text = self.tattooer.name
      cell.shortAddress.text = self.tattooer.shortAddress
      cell.tattooerImage.sd_setImage(with: URL(string: self.tattooer.picture))
      
//      if self.tattoos[indexPath.row].sold == true {
//        cell.status.image = UIImage(named: "status")
//      }
      
    }) { (error) in
      
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //performSegue(withIdentifier: "segueDetailTattoo", sender: indexPath)
  }
  
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //    if segue.identifier == "segueDetailTattoo" {
  //      if let destination = segue.destination as? DetailViewController {
  //        let convertSender = sender as! IndexPath
  //        destination.tattoo = self.tattoos[convertSender.row]
  //        destination.indexPathTattoo = convertSender
  //      }
  //    }
  //  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    var visibleRect = CGRect()
    
    visibleRect.origin = collectionView.contentOffset
    visibleRect.size = collectionView.bounds.size
    
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    
    guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
    
    
          UIView.transition(with: self.tattooImageView,
                            duration: 1,
                            options: .transitionCrossDissolve,
                            animations: { self.tattooImageView.sd_setImage(with:URL(string: self.tattoos[indexPath.row].urlImage))},
                            completion: nil)
    
    
//
//        UIView.transition(with: numberTattooLabel, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
//          self.numberTattooLabel.text = "\(indexPath.row + 1)"
//        }, completion: nil)
    
  }
}

