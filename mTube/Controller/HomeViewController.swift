//
//  HomeVc.swift
//  mTube
//
//  Created by DNA-Z on 6/29/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ModelDelegate {
   
    
    var model = Model()
    //Video from the API...........
    var videos = [Video]()
    //video player view
    let videoLauncher = VideoLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //checking network for youtube API
        model.getVideo()
        //set itself as the  delegate of the model
        model.delegate = self
        
        navigationItem.title = "Home"
        collectionView?.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: Constants.VIDEOCELL_ID)
    }
    
    
    //__MODEL delegate methods
    func videosFetched(_ videos: [Video]) {
        // Set the returned videos to our video property
        self.videos = videos
        
        // Refresh collectionView
        collectionView.reloadData()
    //        print("datafetched \(videos)")
    }
    //__MODEL CollectionViews methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoCell
        
        //configure the cell with the data
        let videoCell = self.videos[indexPath.row]
        cell.setvCell(videoCell)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return .init(width: view.frame.width, height: height + 16 + 68)
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        videoLauncher.showVideoPlayer()
    }
    
    
}

