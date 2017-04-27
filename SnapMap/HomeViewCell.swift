//
//  HomeViewCell.swift
//  SnapMap
//
//  Created by Lum Situ on 4/12/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import FirebaseStorage

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    var post: Post! {
        didSet {
            let imageRef = FIRStorage.storage().reference().child("\(post!.postId!).png")
            imageRef.downloadURL { (Url: URL?, error: Error?) in
                if let error = error {
                    print("Getting imageUrl error:\(error.localizedDescription)")
                } else {
                    self.postImage.setImageWith(Url!)
                    
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
