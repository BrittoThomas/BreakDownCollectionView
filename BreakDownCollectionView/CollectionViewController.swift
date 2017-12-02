//
//  CollectionViewController.swift
//  BreakDownCollectionView
//
//  Created by apple on 02/12/17.
//  Copyright © 2017 Britto. All rights reserved.
//

import UIKit

class BreakDownCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewOverLay: UIView!
    
}


class CollectionViewController: UICollectionViewController {
    
    var cellCount = 1
    let minCellCount = 1
    let maxCellCount = 5
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(cellCount, maxCellCount)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BreakDownCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreakDownCell", for: indexPath) as! BreakDownCell
        cell.titleLabel.text = "Section " + "\(indexPath.row)"
        cell.backgroundColor = UIColor.init(red: CGFloat(arc4random()).truncatingRemainder(dividingBy: 255.0)/255.0, green: CGFloat(arc4random()).truncatingRemainder(dividingBy: 255.0)/255.0, blue: CGFloat(arc4random()).truncatingRemainder(dividingBy: 255.0)/255.0, alpha: CGFloat(arc4random()).truncatingRemainder(dividingBy: 255.0)/255.0)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (cellCount - 2) {
            if cellCount > minCellCount {
                 cellCount -= 1
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [IndexPath.init(row: (indexPath.row + 1), section: indexPath.section)])
                },completion: { (success) in
                   
                })
            }
        }else if indexPath.row == (cellCount - 1) {
            if cellCount < maxCellCount {
                 cellCount += 1
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: [IndexPath.init(row: (indexPath.row + 1), section: indexPath.section)])
                },completion: { (success) in
                   
                })
            }
        }
    }

}

