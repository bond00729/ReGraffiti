//
//  FavoriteArtViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class FavoriteArtViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteArray = UserDefaults.standard.object(forKey: "favorites") as! [Int]
        print(favoriteArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var favoriteArray: [Int] = UserDefaults.standard.object(forKey: "favorites") as! [Int]
    @IBOutlet weak var tb: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count: " + String(favoriteArray.count))
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favArt")! as! FavoriteArtTableViewCell
        let n = (indexPath as NSIndexPath).row
        
        let urlBaseLink = "http://45.63.35.59:8081/image?id="
        
        if let url = NSURL(string: urlBaseLink + String(favoriteArray[n])) {
            if let data = NSData(contentsOf: url as URL) {
                cell.favGraffitiImage.image = UIImage(data: data as Data)
            }
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        tb.reloadData()
    }
}
