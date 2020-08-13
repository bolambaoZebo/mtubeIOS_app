//
//  VideoCell.swift
//  mTube
//
//  Created by DNA-Z on 6/30/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell{
    
    var video:Video?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let tumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profImageView: UIImageView = {
       let pImageView = UIImageView()
        pImageView.backgroundColor = UIColor.red
        pImageView.translatesAutoresizingMaskIntoConstraints = false
        pImageView.layer.cornerRadius = 22
        pImageView.layer.masksToBounds = true
        return pImageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UITextView = {
        let description = UITextView()
        description.isEditable = false
        description.isScrollEnabled = false
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        description.text = "============"
        return description
    }()
    
    func setvCell(_ v:Video){
        
        self.video = v
        
        //ensure that there is a video
        guard self.video != nil else {
            return
        }
        
        //set title
        self.titleLabel.text = video?.title
        //set description
        self.descriptionLabel.text = video?.description
        
        //set up the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //check if there is an cache for thumbnail
        if let cahceData = CacheManager.getVideo(self.video!.thumbnail){
            //set thumbnail imae
            self.tumbnailImageView.image = UIImage(data: cahceData)
            return
        }
        //download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //get the share URL Session object
        let session = URLSession.shared
        
        //create a data task
        let dataTask = session.dataTask(with: url!){ (data, reponse, error) in
            
            if error == nil && data != nil{
                //save the data in cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.video?.thumbnail{
                    //video cell has been recycled for anothe video
                    //and no longer matcher the thumbnail that was download
                    return
                }
                //create the image object
                let imageV = UIImage(data: data!)
                //set the imageview
                DispatchQueue.main.async {
                    self.tumbnailImageView.image = imageV
                    self.profImageView.image = imageV
                }
                
            }
            
        }
        
        //start data task
        dataTask.resume()
        
    }
    
    func setupViews(){
        addSubview(tumbnailImageView)
        addSubview(separatorView)
        addSubview(profImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        //lifecycle testing for the app
    
        addConstraintsWithFormant(format: "H:|-16-[v0(44)]", views: profImageView)
        addConstraintsWithFormant(format: "H:|-16-[v0]-16-|", views: tumbnailImageView)
        addConstraintsWithFormant(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: tumbnailImageView,profImageView,separatorView)
        addConstraintsWithFormant(format: "H:|[v0]|", views: separatorView)
        
        //title and description view modified
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: tumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: tumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: profImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: tumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init{CODER:} has not been implemented")
    }
}


extension UIView {
    func addConstraintsWithFormant(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
}

           

