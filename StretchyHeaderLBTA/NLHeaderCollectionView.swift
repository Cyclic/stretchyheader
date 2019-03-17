//
//  HeaderCollectionView.swift
//  StretchyHeaderLBTA
//
//  Created by Thomas Goddard on 3/16/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

class NLHeaderCollectionView: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let Identifier = "NLHeaderCollectionView"
    
    var images : [String]?
    
    var animator: UIViewPropertyAnimator!
    
    var layout : NLStretchyHeaderLayout!
    
    var isInitialLoad : Bool = true
    
    fileprivate func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: { [weak self] in
            
            // treat this area as the end state of your animation
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            // This is needed to prevent the visual effects view from blocking the collectionview
            visualEffectView.isUserInteractionEnabled = false
            self?.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //blur
        setupVisualEffectBlur()
        setupCollectionView()
        loadCollectionViewImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.images else {
            return 0
        }
        if images.count > 0  {
            return images.count
        } else {
            return 1
        }
    }
    
    func setupCollectionView() {
        
        self.collectionView.register(UINib.init(nibName: NLStretchyCollectionViewHeaderCell.Identifier, bundle: nil), forCellWithReuseIdentifier: NLStretchyCollectionViewHeaderCell.Identifier)
        
        layout = NLStretchyHeaderLayout.init()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0;
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.backgroundColor = .magenta
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.scrollsToTop = false
        self.collectionView.isExclusiveTouch = false
        self.collectionView.isMultipleTouchEnabled = true
        self.collectionView.isOpaque = true
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func loadCollectionViewImages() {
        self.images = ["1", "2", "3"]
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NLStretchyCollectionViewHeaderCell.Identifier, for: indexPath) as? NLStretchyCollectionViewHeaderCell
        let imageName = self.images?[indexPath.row]
        if let imageName = imageName, let cell = cell {
            cell.imageView.image = UIImage.init(named: imageName)
        }
        if isInitialLoad && indexPath.row == 0 {
            cell?.isAtRest = true
            self.isInitialLoad = false
        }
        return cell!
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y:visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            if let cell : NLStretchyCollectionViewHeaderCell = self.collectionView.cellForItem(at: visibleIndexPath) as? NLStretchyCollectionViewHeaderCell {
                cell.isAtRest = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize.init(width: frameSize.width, height: frameSize.height)
    }
}
