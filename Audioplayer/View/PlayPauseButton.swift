//
//  PlayPauseButton.swift
//  Audioplayer
//
//  Created by Andrew on 03.07.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit

@IBDesignable
class PlayPauseButton: UIButton {
    
    @IBInspectable
    var image: UIImage?
    
    override func draw(_ rect: CGRect) {
        self.setImage(image, for: .normal)
    }
    
    func ChangeImage(_ isPlaying: Bool) {
        if isPlaying {
            self.setImage(UIImage(named: "Play.png"), for: .normal)
        } else {
            self.setImage(UIImage(named: "Pause.png"), for: .normal)
        }
    }
}
