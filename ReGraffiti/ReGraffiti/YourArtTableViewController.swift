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
    @IBOutlet var tb: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.myArtArray = UserDefaults.standard.array(forKey: "myArt")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myArtArray!.count)
        return myArtArray!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourArtCell", for: indexPath) as! YourArtCell
        

        let n = (indexPath as NSIndexPath).row
        
        let urlBaseLink = "http://104.238.156.117:8081/image?id="
        
        if let url = NSURL(string: urlBaseLink + String(describing: (myArtArray?[n])!)) {
            if let data = NSData(contentsOf: url as URL) {
                cell.cellArt.image = UIImage(data: data as Data)
            }
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myArtArray = UserDefaults.standard.array(forKey: "myArt")
        super.viewWillAppear(animated)
        tb.reloadData()
    }
}
