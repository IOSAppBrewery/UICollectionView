//
//  BaseCollectionViewLayout.swift
//  CollectionView
//
//  Created by Nelson on 3/9/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit

class BaseCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()
    private var columnYOffset : [CGFloat]!
    private var contentSize : CGSize!
    
    var totalItemsInSection = 0
    
    var totalColumns = 0
    var interItemsSpacing: CGFloat = 8
    
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
    
    override var collectionViewContentSize: CGSize{
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for(_, attribute) in layoutMap{
            if attribute.frame.intersects(rect){
                layoutAttributes.append(attribute)
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView!.bounds != newBounds
    }
    
    override func prepare() {
        
        //remove all previous calcualted data
        layoutMap.removeAll()
        //init column y at 0 for number of columns
        columnYOffset = Array(repeating: 0, count: totalColumns)
        //get total items in collection view
        totalItemsInSection = self.collectionView!.numberOfItems(inSection: 0)
        
        //calcualte if we have items and columns
        if(totalItemsInSection > 0 && totalColumns > 0){
            
            //call abstract method for calculating item size
            self.calculateItemsSize()
            
            //track item index
            var itemIndex = 0;
            
            //collection view's  height for content
            var contentSizeHeight : CGFloat = 0
            
            //iterate each items
            while itemIndex < totalItemsInSection{
                
                //create IndexPath for item
                let indexPath = IndexPath(item: itemIndex, section: 0)
                //call abstract method for column index this item should be in
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                //call abstract method for item frame
                let attributeRect = self.calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: columnYOffset[columnIndex])
                //create attribute with IndexPath
                let targetLayoutAttribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                //set attribute's frame
                targetLayoutAttribute.frame = attributeRect
                
                //update content size height for collection view
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                //update y offset for column at column index
                columnYOffset[columnIndex] = attributeRect.maxY + interItemsSpacing
                //add attribute
                layoutMap[indexPath] = targetLayoutAttribute
                
                //increase item index
                itemIndex += 1
                
            }
            
            //set content size
            contentSize = CGSize(width: self.collectionView!.bounds.width - contentInsets.left - contentInsets.right, height: contentSizeHeight)
        }
        
    }
    
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        return indexPath.item % totalColumns
    }
    
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        return CGRect.zero
    }
    
    func calculateItemsSize() {
        
    }
}
