//
//  DetailsVC.swift
//  Daft Countries
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {
    var country : Country?
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        if let country = country{
            detailsLabel.text =
                "Name:\t\(country.name)"
                + "\nNative Name:\t\(country.nativeName)"
                + "\nCapital:\t\(country.capital)"
                + "\nPopulation:\t\(country.population) people"
                + "\nArea:\t\(country.area ?? 0.0) km²"

            if country.latlng.count == 2{
                let lat = country.latlng[0]
                let lon = country.latlng[1]
                let locationToZoom = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
                zoomOnPlace(location: locationToZoom, area : country.area ?? 10000)
            }
        }
    }
}

extension DetailsVC : MKMapViewDelegate{

    func zoomOnPlace(location: CLLocationCoordinate2D, area : Double){

        let meters = CLLocationDistance(exactly: sqrt(area) * 1000 * 2.0)!
        let region = MKCoordinateRegion(center: location, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region,animated:true)
    }
}
