//
//  UserProfileVC.swift
//  mTube
//
//  Created by DNA-Z on 7/8/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import UIKit

struct userData{
       var userImageProf = ""
       var userName = ""
       var channelTitle = ""
       var userLike = 0
       var userUnlike = 0
       var userSubscriber = 0
       
   }

class UserProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postText: UITextField!
    @IBOutlet weak var userNamelb: UILabel!
    @IBOutlet weak var unpressbtn: UIButton!
    
    @IBOutlet weak var table1: UITableView!
    
    
    var user = [userData(userImageProf: "now", userName: "melo", channelTitle: "monkeyman", userLike: 2, userUnlike: 23, userSubscriber: 2),userData(userImageProf: "ker", userName: "dany", channelTitle: "Ironman", userLike: 2, userUnlike: 23, userSubscriber: 2)]
    
    
    @IBAction func unpress(_ sender: Any) {
        unpressbtn.isHidden = true
        postText.text = ""
        print("cancel post")
    }
    @IBAction func pressBtn(_ sender: Any) {
        unpressbtn.isHidden = false
        print("post data")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //main loader for view
        unpressbtn.isHidden = true
        navigationItem.title = "User Profile"
        
        table1.delegate = self
        table1.dataSource = self
       
        table1.register(MyCell.self, forCellReuseIdentifier: "cellId")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
   
}

class MyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        
    }
    
    
}
