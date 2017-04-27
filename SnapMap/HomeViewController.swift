//
//  HomeViewController.swift
//  SnapMap
//
//  Created by Jason Wong on 3/21/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth
import FirebaseStorage
import Firebase
import FirebaseDatabase
import MapKit
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var snapUsers = [User]()
    var snapPosts = [Post]()
    
    var photoUrl = [URL]()
    
//    var dbref = FIRDatabase.database().reference(fromURL: "https://snapmap-e45c3.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapView.alpha = 0
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        retrieveUsers()
        retrievePosts()
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        for post in snapPosts {
//            locationsPickedLocation(latitude: post.latitude, longitude: post.longitude)
//        }
//    }
    
    func retrieveUsers()
    {
        FIRDatabase.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            if let userdictionary = snapshot.value as? [String: Any]
            {
                let user = User()
                
//                print(snapshot.value)
                user.name = userdictionary["name"] as! String
                user.email = userdictionary["email"] as? String
                user.profileURL = userdictionary["profileURL"] as? String
                
                self.snapUsers.append(user)
                //print("user count is : \(self.snapUsers.count)")
            }
        })
    }
    
    func retrievePosts()
    {
        var postDictionary: NSDictionary = [:]
        
        FIRDatabase.database().reference().child("Post").observe(.childAdded, with: { (snapshot) in
                for childSnap in  snapshot.children.allObjects
                {
                    let post = Post()

                    let snap = childSnap as! FIRDataSnapshot
                    
                    if let snapshotValue = snapshot.value as? NSDictionary, let snapVal = snapshotValue[snap.key] as? NSDictionary
                    {
                        for postInfo in snapVal {
                            postDictionary = (postInfo.value as? NSDictionary)!
                            print(postDictionary)
                        }
                        
//                        print(postDictionary)
//                        print(self.snapPosts.count)
                        if let latitude = postDictionary["latitude"] {
                            post.latitude = latitude as! Double
                        }
//                        post.latitude = postDictionary["latitude"] as! Double
                        
                        if let longitude = postDictionary["longitude"] {
                            post.longitude = longitude as! Double
                        }
//                        post.longitude = postDictionary["longitude"] as! Double
                        
                        if let id = postDictionary["postId"] {
                            post.postId = id as! String
                        }
                        
                        if let text = postDictionary["text"] {
                            post.text = text as! String
                        }
                        
                        self.snapPosts.append(post)
                        //DispatchQueue.main.async {
                            self.tableView.reloadData()
                        //}
                    }
                }
        })
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        retrievePosts()
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        FBSDKAccessToken.setCurrent(nil)
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginviewcontroller: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController")
        self.present(loginviewcontroller, animated: true, completion: nil)

        
    
    }
    
    @IBAction func toMapView(_ sender: UIBarButtonItem) {
        tableView.alpha = 0
        mapView.alpha = 1
        print("switch to mapview")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView" {
            let vc = segue.destination as! MapViewController
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapPosts.count
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        let post = snapPosts[indexPath.row]
        //print(post)
//        let imageRef = FIRStorage.storage().reference().child("\(post.postId!).png")
//        imageRef.downloadURL { (Url: URL?, error: Error?) in
//            if let error = error {
//                print("Getting imageUrl error:\(error.localizedDescription)")
//            } else {
//                cell.imageUrl = Url
//            }
//            
//        }

        cell.post = post
        
        return cell
    }
    
//    func locationsPickedLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        
//        let annotation = MKPointAnnotation()
//        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude as CLLocationDegrees, longitude: longitude as CLLocationDegrees)
//        annotation.coordinate = locationCoordinate
//        annotation.title = String(describing: latitude)
//        mapView.addAnnotation(annotation)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
