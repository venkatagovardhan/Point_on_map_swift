//
//  ViewController.swift
//  Point_on_map_swift
//
//  Created by venkatagovardhan on 3/13/18.
//  Copyright © 2018 venkatagovardhan. All rights reserved.
//

import UIKit
import MapKit

var locations = [
    ["title": "De Paul University",    "latitude": 41.877517, "longitude": -87.627181],
    ["title": "Melinium Park", "latitude": 41.882291, "longitude": -87.622549],
    ["title": "Starbucks",     "latitude": 41.882243, "longitude": -87.624588],
    ["title": "Art Institute of Chicago",     "latitude": 41.879400, "longitude": -87.623858],
    ["title": "Target",     "latitude": 41.881908, "longitude": -87.627441]
]

var addpointlat: Double?
var addpointlong: Double?



class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var MainMap: MKMapView!
    
    @IBOutlet weak var MenuButton: UIButton!
    
    @IBOutlet weak var AddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //map points arrays.
        
        AddButton.isHidden = true
        
        
        for location in locations {
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.02)
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(annotation.coordinate, span)
            MainMap.setRegion(region, animated: true)
            MainMap.addAnnotation(annotation)
        }
        
        
        let gestureRecognizer = UILongPressGestureRecognizer (target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
       gestureRecognizer.minimumPressDuration = 0.5
        MainMap.addGestureRecognizer(gestureRecognizer)
        
       
        
        //SWReveal viewcontroller
        MenuButton.addTarget(self.revealViewController(), action: "revealToggle:", for: UIControlEvents.touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: MainMap)
        let coordinate = MainMap.convert(location,toCoordinateFrom: MainMap)
       
        print(coordinate.longitude)
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        MainMap.addAnnotation(annotation)
        addpointlat = coordinate.latitude
        addpointlong = coordinate.longitude
        AddButton.isHidden = false
        
        
    }

   
    @IBAction func ButtonAction(_ sender: Any) {
        locations.append(["title": "New Place",    "latitude": addpointlat, "longitude": addpointlong])
        AddButton.isHidden = true
    }
}


