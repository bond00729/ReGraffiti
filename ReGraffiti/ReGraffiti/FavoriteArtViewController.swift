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
        favoriteArray = UserDefaults.standard.object(forKey: "favorites") as? [Int]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var favoriteArray: [Int]?
    @IBOutlet weak var tb: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favArt")! as! FavoriteArtTableViewCell
        let n = (indexPath as NSIndexPath).row
        
        let urlBaseLink = "http://104.238.156.117:8081/image?id="
        
        if let url = NSURL(string: urlBaseLink + String((favoriteArray?[n])!)) {
            if let data = NSData(contentsOf: url as URL) {
                cell.favGraffitiImage.image = UIImage(data: data as Data)
            }
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteArray = UserDefaults.standard.object(forKey: "favorites") as? [Int]
        super.viewWillAppear(animated)        
        tb.reloadData()
    }
}
