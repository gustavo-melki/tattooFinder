//
//  TattooerCollectionViewCell.swift
//  TattooFinder
//
//  Created by Gustavo Melki Leal on 27/08/2018.
//  Copyright © 2018 Gustavo Melki Leal. All rights reserved.
//

import UIKit

class TattooerCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var tattooerImage: UIImageView!
  @IBOutlet weak var artistName: UILabel!
  @IBOutlet weak var shortAddress: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    tattooerImage.clipsToBounds = true
    tattooerImage.layer.cornerRadius = 35
  }
  
  
}
