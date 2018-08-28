//
//  GradientView.swift
//  TattooFinder
//
//  Created by Gustavo Melki Leal on 28/08/2018.
//  Copyright © 2018 Gustavo Melki Leal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GradientView: UIView {
  @IBInspectable var topColor: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
  @IBInspectable var bottomColor: UIColor = UIColor.black
  
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  override func layoutSubviews() {
    (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
  }
}
