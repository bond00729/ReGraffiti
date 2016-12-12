//
//  AroundYouViewController.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/11/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit
import MapKit

class AroundYouViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        map.showsBuildings = true
        map.showsScale = true
        map.showsCompass = true
        
        map.delegate = self
    }
    
    // http://www.techotopia.com/index.php/Working_with_Maps_on_iOS_8_with_Swift,_MapKit_and_the_MKMapView_Class
    @IBAction func zoomIn(_ sender: UIBarButtonItem) {
        let userLocation = map.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        map.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
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
