//
//  YourArtTableViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class YourArtTableViewController: UITableViewController {
    var yourArtImages = YourArtTableViewController.getYourArt(key: "user-images")
    var yourArtLocation = YourArtTableViewController.getYourArt(key: "user-locations")
    
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
        
        self.yourArtImages = YourArtTableViewController.getYourArt(key: "user-images")
        self.yourArtLocation = YourArtTableViewController.getYourArt(key: "user-locations")
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
        return self.yourArtImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourArtCell", for: indexPath) as! YourArtTableViewCell
        
        let cellImage = self.yourArtImages[indexPath.row] as! UIImage
        let cellLocation = self.yourArtLocation[indexPath.row] as! UILabel
        cell.artImage.image = cellImage
        cell.artLocation.text = cellLocation.text
        
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
            self.yourArtImages.remove(at: indexPath.row)
            
            var array = YourArtTableViewController.getYourArt(key: "art")
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array, forKey: "art")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
