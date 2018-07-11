//
//  CollectionViewController.swift
//  ViewAnimator_Example
//
//  Created by Marcos Griselli on 04/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ViewAnimator

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController {
    
    private var items = [Any?]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 20)
        collectionView?.reloadData()
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.visibleCells,
                animations: animations, completion: {
                sender.isEnabled = true
                })
        }, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: collectionView!.visibleCells,
                       animations: animations, reversed: true,
                       initialAlpha: 1.0,
                       finalAlpha: 0.0,
                       completion: {
                        self.collectionView?.reloadData()
                        self.activityIndicator.startAnimating()
        })
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}
