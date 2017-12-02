//
//  BreakDownCollectionViewLayout.swift
//  BreakDownCollectionView
//
//  Created by apple on 02/12/17.
//  Copyright © 2017 Britto. All rights reserved.
//

import UIKit

struct BreakDownLayoutLayoutConstants {
    struct Cell {
        static let colapseHeight: CGFloat = 100
        static let openHeight: CGFloat = 280
    }
}

class BreakDownCollectionViewLayout: UICollectionViewLayout {
    
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            return collectionView!.bounds.height
        }
    }
    
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    // MARK: UICollectionViewLayout
    override var collectionViewContentSize: CGSize{
        let contentHeight = (CGFloat(numberOfItems) * BreakDownLayoutLayoutConstants.Cell.colapseHeight) +
            max((BreakDownLayoutLayoutConstants.Cell.openHeight - BreakDownLayoutLayoutConstants.Cell.colapseHeight),0)
        return CGSize(width: width, height: contentHeight)
    }
    
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        let colapseHeight = BreakDownLayoutLayoutConstants.Cell.colapseHeight
        let openHeight = BreakDownLayoutLayoutConstants.Cell.openHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            // 1
            let indexPath = IndexPath(item:item, section:0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 2
            attributes.zIndex = item
            var height = colapseHeight
            
            if indexPath.item == (numberOfItems - 1) {
                height = openHeight
            }
            // 6
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = y + height
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
