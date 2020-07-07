//
//  AudioCell.swift
//  Audioplayer
//
//  Created by Andrew on 02.07.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

@IBDesignable
class AudioCell: UICollectionViewCell {
    @IBOutlet weak var songName: UILabel!
    
    @IBInspectable
    var cR: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cR
    }
}
