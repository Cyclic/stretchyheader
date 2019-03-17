//
//  StretchyCollectionViewCell.swift
//  StretchyHeaderLBTA
//
//  Created by Thomas Goddard on 3/16/19.
//  Copyright © 2019 Neutrino Labs. All rights reserved.
//

import UIKit

class NLStretchyCollectionViewHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public var isAtRest = false
    
    static let Identifier = "NLStretchyCollectionViewHeaderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isAtRest {
            if let superview = superview {
                self.frame = CGRect.init(x: self.frame.origin.x, y: superview.frame.origin.y, width: superview.frame.size.width, height: superview.frame.size.height)
            }
        }
    }
}
