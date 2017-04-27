//
//  CaptureViewController.swift
//  SnapMap
//
//  Created by Lum Situ on 4/19/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class CaptureViewController: UIViewController {

    @IBOutlet weak var captureImage: UIImageView!
    @IBOutlet weak var captureText: UITextView!
    
    var image: UIImage!
    
    var dbref = FIRDatabase.database().reference(fromURL: "https://snapmap-e45c3.firebaseio.com/")
    let user = FIRAuth.auth()?.currentUser
    var postId: String!
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureImage.image = image
        captureText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @IBAction func toLocationView(for segue: UIStoryboardSegue, _ sender: UIBarButtonItem) {
//        let locationsViewController = segue.destination as! LocationsViewController
//
//        locationsViewController.delegate = self
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView" {
            text = captureText.text
            let locationsViewController = segue.destination as! LocationsViewController
            //locationsViewController.delegate = self
            locationsViewController.postId = self.postId
            locationsViewController.text = self.text
        }
    }

//    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
//        
//        let geoRef = dbref.child("Post").child("userid: \(user!.uid)").childByAutoId()
//        geoRef.child("location").child("longitude").setValue(longitude)
//        geoRef.child("location").child("latitude").setValue(latitude)
//        geoRef.child("location").child("postId").setValue(self.postId)
//        geoRef.child("location").child("name").setValue(user!.displayName)
//        geoRef.child("location").child("text").setValue(text)
//        print("upload seccessfully!")
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
