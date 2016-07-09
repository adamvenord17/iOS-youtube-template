//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Adam Venord on 6/22/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

import UIKit


class TrendingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    var itemsList = [[String : AnyObject]] ()
    var videoItems = [Int : Video]()
    let refresh = UIRefreshControl()
    
    
    //MARK: Methods
    func customization() {
        
        //CollectionView customization
        self.collectionView?.contentInset = UIEdgeInsetsMake(21, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(21, 0, 0, 0)
        
        //Refresh Control
        refresh.addTarget(self, action: #selector(TrendingCollectionViewController.refreshContent), for: UIControlEvents.valueChanged)
        self.refresh.tintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        self.collectionView?.addSubview(self.refresh)
        
    }
    
    func refreshContent()  {
        self.videoItems.removeAll()
        fetchItemsList(link: globalVariables.moreURLLink)
    }
    
    func fetchItemsList(link: URL) {
        Video.getVideosList(fromURL: link) { (items) -> (Void) in
            self.itemsList += items
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                UIApplication.shared().isNetworkActivityIndicatorVisible = false
                self.refresh.endRefreshing()
            })
        }
    }

    
    //MARK: -  ViewController Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        fetchItemsList(link: globalVariables.moreURLLink)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsList.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var returncell = UICollectionViewCell()
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Top", for: indexPath) as! TrendingItemsCell
            print("aa \(cell.subviews)")
            returncell = cell
        } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
                cell.resetCell()
                if let video = videoItems[indexPath.row - 1] {
                    cell.setupCell(videoItem: video)
                } else{
                    Video.object(at: (indexPath.row - 1), fromList: itemsList, completiotion: { (video, index) in
                        self.videoItems[index] = video
                        DispatchQueue.main.async(execute: {
                            self.collectionView?.reloadData()
                            UIApplication.shared().isNetworkActivityIndicatorVisible = false
                        })
                    })
                }
                returncell = cell
        }
        return returncell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if indexPath.row == 0 {
            size = CGSize.init(width: UIScreen.main().bounds.width, height: 100)
        } else {
        size = CGSize.init(width: UIScreen.main().bounds.width, height: 300)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            fetchItemsList(link: globalVariables.urlLink)
        }
    }
    
}

    //MARK TopCellClass

class TrendingItemsCell: UICollectionViewCell {
    
    @IBOutlet var buttons: [UIButton]!
    
    func roundCorners()  {
        for button in self.buttons {
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
        }
    }
    
    //MARK: Inits
  
    override func awakeFromNib() {
        roundCorners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}










