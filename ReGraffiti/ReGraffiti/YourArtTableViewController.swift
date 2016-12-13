//
//  YourArtTableViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/12/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class YourArtTableViewController: UITableViewController {
    var myArtArray = UserDefaults.standard.array(forKey: "myArt")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // should be myArtArray.count
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourArtCell", for: indexPath) as! YourArtCell
        

        // Configure the cell...
        // call JSON to get location/date using id from myArtArray
        // call JSON to get image using id from myArtArray
        cell.dateLabel.text = "12/12/2016"
        cell.locationLabel.text = "Seattle"
        cell.cellArt.image = #imageLiteral(resourceName: "launchbackground")
        return cell
    }
}
