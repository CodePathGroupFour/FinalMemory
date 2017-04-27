//
//  AVFoundationForCamera.swift
//  SnapMap
//
//  Created by Lum Situ on 4/26/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class AVFoundationForCamera: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //
    //        session = AVCaptureSession()
    //        session!.sessionPreset =  AVCaptureSessionPresetPhoto
    //
    //        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //
    //        var error: Error?
    //        var input: AVCaptureInput!
    //        do {
    //            input = try AVCaptureDeviceInput(device: backCamera)
    //        } catch let error1 as Error {
    //            error = error1
    //            input = nil
    //            print(error!.localizedDescription)
    //        }
    //
    //        if error == nil && session!.canAddInput(input) {
    //            session!.addInput(input)
    //        }
    //
    //        stillImageOutput = AVCaptureStillImageOutput()
    //        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
    //
    //        if session!.canAddOutput(stillImageOutput) {
    //            session!.addOutput(stillImageOutput)
    //        }
    //
    //        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
    //        videoPreviewLayer!.videoGravity = AVLayerVideoGravityResize
    //        videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
    //        previewView.layer.addSublayer(videoPreviewLayer!)
    //        session!.startRunning()
    //    }
    //
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(true)
    //        videoPreviewLayer!.frame =  previewView.bounds
    //    }
    //
    //    @IBAction func takePhotoButton(_ sender: UIButton) {
    //        if let videoConnetion = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
    //            stillImageOutput?.captureStillImageAsynchronously(from: videoConnetion, completionHandler: { (sampleBuffer: CMSampleBuffer?, error: Error?) in
    //
    //                if sampleBuffer != nil {
    //                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
    //                    let dataProvider = CGDataProvider(data: imageData as! CFData)
    //                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
    //                    let captureImage = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
    //
    //                    self.captureImageView.image = captureImage
    //
    //                    let imageName = NSUUID().uuidString
    //
    //
    //                    guard let uid = self.user?.uid else {
    //                        return
    //                    }
    //
    //                    // Create a reference to the file you want to upload
    //                    var storageRef = FIRStorage.storage().reference().child("\(imageName).png")
    //
    //                    if let uploadData = UIImagePNGRepresentation(captureImage) {
    //                        //let uid = self.user?.uid
    //                            storageRef.put(uploadData, metadata: nil) { metadata, error in
    //                            if let error = error {
    //                                // Uh-oh, an error occurred!
    //                                print(error.localizedDescription)
    //                                print("?????????")
    //                            } else {
    //                                // Metadata contains file metadata such as size, content-type, and download URL.
    //                                print("upload seccessfully!")
    //                                let postImageURL = metadata!.downloadURL()
    //                                if let postImageURL = metadata!.downloadURL()?.absoluteString {
    //                                    let value = ["postImageURL": postImageURL]
    //
    //                                   self.registerUserIntoDataBaseWithUID(uid: uid, values: value as [String : AnyObject])
    //                                }
    //                            }
    //                        }
    //                    }
    //
    //
    //
    //                }
    //            })
    //        }
    //
    //
    //    }//func takePhotoButton
    //
    //    private func registerUserIntoDataBaseWithUID(uid:String, values:[String:AnyObject]) {
    //        let ref = FIRDatabase.database().reference(fromURL: "https://snapmap-e45c3.firebaseio.com/")
    //        let userRef = ref.child("user").child(uid)
    //        userRef.updateChildValues(values,withCompletionBlock: {
    //            (err,ref) in
    //            if err != nil {
    //                print(err?.localizedDescription)
    //                return
    //            }
    //            
    ////            self.dismiss(animated: true, completion: nil)
    //        })
    //    }

}
