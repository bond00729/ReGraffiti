//
//  NewArtViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class NewArtViewController: UIViewController {
    var current = -1
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    let urlString: String = "http://45.63.35.59:8081/new_images"
    var date: [String] = []
    var id: [Int] = []
    var location: [String] = []
    var image: [UIImage] = []
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the User Defaults for favorite graffitis
        let defaults = UserDefaults.standard
        if  defaults.object(forKey: "favorites") == nil {
            let favoriteArray: [Int] = [Int]()
            defaults.set(favoriteArray, forKey: "favorites")
        }

        // Do any additional setup after loading the view.
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Dictionary<String, AnyObject>]
                    
                    for art in parsedData  {
                        self.date.insert(art["date"] as! String, at: 0)
                        self.location.insert(art["location"] as! String, at: 0)
                        self.id.insert(art["id"] as! Int, at: 0)
                        
                        let imageURL = URL(string: "http://45.63.35.59:8081/image?id=\(self.id[0])")
                        let imageData = try Data(contentsOf: imageURL!)
                        let image = UIImage(data: imageData)!
                        self.image.insert(image, at: 0)
                    }
                } catch {
                    print("Error loading data")
                }
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextImage(_ sender: UIBarButtonItem) {
        if current < date.count - 1 {
            current += 1;
        }

        updateImage()
    }

    @IBAction func previousImage(_ sender: UIBarButtonItem) {
        if current > 0 {
            current -= 1;
        }

        updateImage()
    }
    
    @IBAction func openInAppleMaps(_ sender: AnyObject) {
        if current > -1 {
            var url = location[current]
            url = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            let str = "http://maps.apple.com/?address=" + url
            print(str)
            UIApplication.shared.openURL(NSURL(string: str)! as URL)
        }
    }
    
    func updateImage() {
        locationLabel.text = location[current]
        artImage.image = image[current]
        
        let favoriteArray: [Int] = UserDefaults.standard.object(forKey: "favorites") as! [Int]
        if favoriteArray.contains(id[current]) {
            favoriteButton.setImage(UIImage(named: "favoriteFull"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
        }
    }
    
    @IBAction func favoriteGraffiti(_ sender: UIButton) {
        if current != -1 {
            if sender.currentImage == UIImage(named: "favoriteEmpty") {
                sender.setImage(UIImage(named: "favoriteFull"), for: .normal)
                
                let defaults = UserDefaults.standard
                var favoriteArray:[Int] = defaults.object(forKey: "favorites") as! [Int]
                favoriteArray.append(id[current])
                defaults.set(favoriteArray, forKey: "favorites")
            } else {
                sender.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
                
                let defaults = UserDefaults.standard
                var favoriteArray:[Int] = defaults.object(forKey: "favorites") as! [Int]
                for i in 0...favoriteArray.count-1 {
                    if favoriteArray[i] == id[current] {
                        favoriteArray.remove(at: i)
                        break
                    }
                }
                defaults.set(favoriteArray, forKey: "favorites")
            }
        }
    }
    
}
