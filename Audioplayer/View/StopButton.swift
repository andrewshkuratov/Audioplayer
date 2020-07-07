//
//  StopButton.swift
//  Audioplayer
//
//  Created by Andrew on 03.07.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

@IBDesignable
class StopButton: UIButton {
    @IBInspectable
    var image: UIImage?
    
    override func draw(_ rect: CGRect) {
        self.setImage(image, for: .normal)
    }
}
