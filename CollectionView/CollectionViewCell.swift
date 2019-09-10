//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Nelson on 3/9/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5
    }
}
