//
//  GalleryLayoutV2.swift
//  CollectionView
//
//  Created by Nelson on 3/9/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit

private let kNumImagePerSet = 4

class GalleryLayoutV2: BaseCollectionViewLayout {
    
    private var itemSize : [CGSize]!
    private var columnXOffset : [CGFloat]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.totalColumns = 2
    }
    
    override func calculateItemsSize(){
        
        //content width without left and right inset
        let contentWithoutInset = collectionView!.bounds.size.width - contentInsets.left - contentInsets.right
        //content width without all interval space and include left and right
        let width = contentWithoutInset - CGFloat(self.totalColumns - 1) * self.interItemsSpacing
        
        //item width for first column which is enlarge item and take 2/3 space
        //height is dynamically depend on number of subset item in second column
        let enlargeItemWidth = width * (2/3)
        
        //item width for second column which is small item
        let itemWidth = width - enlargeItemWidth
        
        //item height for second column which is small item
        let itemHeight = itemWidth
        
        itemSize = []
        let numSubset = CGFloat(kNumImagePerSet - 1)
        let subsetHeight = itemHeight * numSubset + (numSubset - 1) * self.interItemsSpacing
        itemSize.append( CGSize(width: enlargeItemWidth, height: subsetHeight))
        itemSize.append( CGSize(width: itemWidth, height: itemHeight))
        
        columnXOffset = []
        columnXOffset.append(0)
        columnXOffset.append( enlargeItemWidth + self.interItemsSpacing)
    }
    
    override func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        
        if(indexPath.item % kNumImagePerSet == 0){
            return 0
        }
        
        return 1
    }
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        
        let itemSizeForColumn = itemSize[columnIndex]
        
        return CGRect(x: columnXOffset[columnIndex], y: columnYoffset, width: itemSizeForColumn.width, height: itemSizeForColumn.height)
    }
}
