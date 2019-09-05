//
//  GalleryLayoutV1.swift
//  CollectionView
//
//  Created by Nelson on 3/9/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit

private let kReducedHeightColumnIndex = 1
private let kItemHeightAspect: CGFloat  = 2

class GalleryLayoutV1: BaseCollectionViewLayout {
    
    private var itemSize : CGSize!
    private var columnXOffset : [CGFloat]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.totalColumns = 3
    }
    
    private func isLastItemSingleInRow(indexPath : IndexPath)->Bool{
        return indexPath.item == (totalItemsInSection-1) && (indexPath.item % totalColumns) == 0
    }
    
    override func calculateItemsSize() {
        
        let contentWidthWithoutInsets = self.collectionView!.bounds.width - contentInsets.left - contentInsets.right
        let itemWidth = (contentWidthWithoutInsets - CGFloat(totalColumns - 1) * interItemsSpacing) / CGFloat(totalColumns)
        let itemHeight = itemWidth * kItemHeightAspect
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        columnXOffset = []
        
        for columnIndex in 0..<totalColumns{
            
            columnXOffset.append(CGFloat(columnIndex) * (itemWidth + interItemsSpacing))
        }
    }
    
    override func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        
        var columnIndex = indexPath.item % totalColumns
        if isLastItemSingleInRow(indexPath: indexPath){
            columnIndex = kReducedHeightColumnIndex
        }
        
        return columnIndex
    }
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        
        let itemWidth = itemSize.width
        var itemHeight = itemSize.height
        
        let row = indexPath.item / totalColumns
        
        if(isLastItemSingleInRow(indexPath: indexPath) || (row == 0 && columnIndex == kReducedHeightColumnIndex)){
            itemHeight = itemSize.height / 2
        }
        
        return CGRect(x: columnXOffset[columnIndex], y: columnYoffset, width: itemWidth, height: itemHeight)
    }
}
