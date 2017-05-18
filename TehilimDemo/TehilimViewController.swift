//
//  TehilimViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 25/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "Cell"

class TehilimViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var chapters: [String]!
    var myTitle: String!
    var tapGesture : UITapGestureRecognizer!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    class func viewController(with chapters : [String], andTitle title: String) -> TehilimViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "TehilimViewController") as! TehilimViewController
        vc.chapters = chapters
        vc.myTitle = title
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.title = myTitle
        collectionView.semanticContentAttribute = .forceRightToLeft
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleHideBarAction))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        super.viewWillDisappear(animated)
    }
    
    func toggleHideBarAction() {
        self.navigationController?.setNavigationBarHidden(!self.navigationController!.isNavigationBarHidden, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TehilimCollectionViewCell
        
        cell.configure(with: UIImage(named: chapters[indexPath.row])!)
        if let gesture = cell.tapGesture{
            self.tapGesture.require(toFail: gesture)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return (collectionView.bounds.size.width < collectionView.bounds.size.height) ? self.view.bounds.size : collectionView.bounds.size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.itemSize = (size.width < size.height) ? self.view.bounds.size : collectionView.bounds.size
            layout.invalidateLayout()
        }
    }
}




















