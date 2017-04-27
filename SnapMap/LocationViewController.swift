//
//  LocationViewController.swift
//  SnapMap
//
//  Created by Edison Lam on 3/29/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//


import UIKit
import Firebase

//protocol LocationsViewControllerDelegate: class {
//    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber)
//}

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
//    weak var delegate: LocationsViewControllerDelegate!
    
    let CLIENT_ID = "QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL"
    let CLIENT_SECRET = "W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results: NSArray = []
    
    var dbref = FIRDatabase.database().reference(fromURL: "https://snapmap-e45c3.firebaseio.com/")
    let user = FIRAuth.auth()?.currentUser
    var postId: String!
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        cell.location = results[(indexPath as NSIndexPath).row] as! NSDictionary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is the selected venue
        let venue = results[(indexPath as NSIndexPath).row] as! NSDictionary
        
        let lat = venue.value(forKeyPath: "location.lat") as! NSNumber
        let lng = venue.value(forKeyPath: "location.lng") as! NSNumber
        
//        let latString = "\(lat)"
//        let lngString = "\(lng)"
        
//        print(latString + " " + lngString)
        
        locationsPickedLocation(controller: self, latitude: lat, longitude: lng)
        
        // Return to the HomeViewController
        performSegue(withIdentifier: "backToHomeView", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        fetchLocations(newText)
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchLocations(searchBar.text!)
    }
    
    func fetchLocations(_ query: String, near: String = "San Francisco") {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20141020&near=\(near),CA&query=\(query)"
        
        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let request = URLRequest(url: url)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,
             completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        NSLog("response: \(responseDictionary)")
                        self.results = responseDictionary.value(forKeyPath: "response.venues") as! NSArray
                        self.tableView.reloadData()
                        
                    }
                }
        });
        task.resume()
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        
        let geoRef = dbref.child("Post").child("userid: \(user!.uid)").childByAutoId()
        geoRef.child("location").child("longitude").setValue(longitude)
        geoRef.child("location").child("latitude").setValue(latitude)
        geoRef.child("location").child("postId").setValue(self.postId)
        geoRef.child("location").child("name").setValue(user!.displayName)
        geoRef.child("location").child("text").setValue(self.text)
        print("upload seccessfully!")
    }
}

