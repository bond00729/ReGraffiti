//
//  YourArtTableViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class YourArtTableViewController: UITableViewController {
    var userImages = CreatePostViewController.getYourArt(key: "user-images")
    var userLocations = CreatePostViewController.getYourArt(key: "user-locations")
    
    
    static func getYourArt(key: String) -> [Any] {
        let yourArt = UserDefaults.standard.array(forKey: key)
        if yourArt == nil {
            return Array()
        } else {
            return yourArt!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userImages = CreatePostViewController.getYourArt(key: "user-images")
        self.userLocations = CreatePostViewController.getYourArt(key: "user-locations")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourArtCell", for: indexPath) as! YourArtTableViewCell
        
        let cellImage = self.userImages[indexPath.row] as! UIImage
        let cellLocation = self.userLocations[indexPath.row] as! UILabel
        cell.artImage.image = cellImage
        cell.artLocation.text = cellLocation.text
        // cell.artImage?.image = (currentCell as AnyObject).image // need to call whatever the api returns
        
        return cell
    }
    
    @IBAction func doneButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.userImages.remove(at: indexPath.row)
            
            var array = YourArtTableViewController.getYourArt(key: "art")
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array, forKey: "art")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
