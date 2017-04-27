//
//  MapViewController.swift
//  SnapMap
//
//  Created by Lum Situ on 4/17/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseDatabase
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var snapUsers = [User]()
    var snapPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveUsers()
        retrievePosts()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for post in snapPosts {
            locationsPickedLocation(latitude: post.latitude, longitude: post.longitude)
        }
    }
    
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
                    }
                    
//                    print(postDictionary)
//                    print(self.snapPosts.count)
                    if let latitude = postDictionary["latitude"] {
                        post.latitude = latitude as! Double
                    }
//                    post.latitude = postDictionary["latitude"] as! Double
                    if let longitude = postDictionary["longitude"] {
                        post.longitude = longitude as! Double
                    }
//                    post.longitude = postDictionary["longitude"] as! Double
                    if let id = postDictionary["postId"] {
                        post.postId = id as! String
                    }
//                    post.postId = postDictionary["postId"] as! String
                    self.snapPosts.append(post)
                    //                        print(self.snapPosts[0].latitude)
                    //                        print(self.snapPosts[0].longitude)
                    //                        print(self.snapPosts[0].postId)
                }
            }
        })
    }
    
    func locationsPickedLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude as CLLocationDegrees, longitude: longitude as CLLocationDegrees)
        annotation.coordinate = locationCoordinate
        annotation.title = String(describing: latitude)
        mapView.addAnnotation(annotation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
