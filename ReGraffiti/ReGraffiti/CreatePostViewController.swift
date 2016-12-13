//
//  CreatePostViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit
import MobileCoreServices

// might need to add mapkit to be able to access the users current location
// get camera roll button to work

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationText: UITextField!
    var newMedia: Bool?
    
    static func getYourArt(key: String) -> [Any] {
        let newPost = UserDefaults.standard.array(forKey: key)
        if newPost == nil {
            return Array()
        } else {
            return newPost!
        }
    }
    
    @IBAction func createPost(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        var myArtArray = defaults.array(forKey: "myArt")
        
        
        if self.locationText.text != nil && self.imageView.image != nil {
            let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
            let imageString = imageData?.base64EncodedString()
            let urlEncoded = imageString?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            print("imageString \(urlEncoded)")
            
            let urlString = "http://104.238.156.117:8081/create_image?image=\(urlEncoded!)&location=\(locationText.text!)"
            let url = URL(string: urlString)!
            
            URLSession.shared.dataTask(with:url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        print(parsedData)
                    } catch {
                        print("Error loading data")
                    }
                }
            }.resume()
            
            let dummy = 0
            myArtArray?.append(dummy)
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if defaults.array(forKey: "myArt") == nil {
            let myArtArray: [Int] = [Int]()
            defaults.set(myArtArray, forKey: "myArt")
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Stuff related to the camera and street art image
    
    // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_iPhone_Camera_Application
    @IBAction func useCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    
    // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_iPhone_Camera_Application
    @IBAction func useCameraRoll(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
    }
    
    // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_iPhone_Camera_Application
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            self.imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(CreatePostViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
    
    // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_iPhone_Camera_Application
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_iPhone_Camera_Application
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
