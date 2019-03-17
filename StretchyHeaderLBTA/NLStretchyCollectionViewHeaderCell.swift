//
//  StretchyCollectionViewCell.swift
//  StretchyHeaderLBTA
//
//  Created by Thomas Goddard on 3/16/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

class NLStretchyCollectionViewHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let Identifier = "NLStretchyCollectionViewHeaderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }

}
