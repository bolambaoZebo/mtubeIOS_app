//
//  Model.swift
//  mTube
//
//  Created by DNA-Z on 6/30/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import Foundation

protocol  ModelDelegate {
    func videosFetched(_ videos:[Video])
}

class Model{

    var delegate:ModelDelegate?
    
    func getVideo() {
       // Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else{
            return
        }
        //Get a URLSession object
        let session = URLSession.shared
        //Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            // check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            do {
                //parsing the data into video object
                           let decoder = JSONDecoder()
                           decoder.dateDecodingStrategy = .iso8601

                let res = try decoder.decode(Response.self, from: data!)
                

                    if res.items != nil {

                    DispatchQueue.main.async {
                        //call the "videoFetched" method of the delegate
                        self.delegate?.videosFetched(res.items!)
                    }
                }

            }catch{

            }
           
            
        }
            //Kick off the task
        dataTask.resume()
    }
    
    
}
