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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
    
    func updateImage() {
        locationLabel.text = location[current]
        artImage.image = image[current]
    }
}
