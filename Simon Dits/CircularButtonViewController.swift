//
//  CircularButtonViewController.swift
//  Simon Dits
//
//  Created by Seedy on 17/10/2024.
//

import UIKit

class CircularButtonViewController: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
//        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                alpha = 1
            }else{
                alpha=0.5
            }
        }
    }

}
