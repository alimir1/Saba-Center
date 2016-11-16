//
//  PrayerTimesViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/11/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import CoreLocation

class PrayerTimesViewController: UITableViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    var locationManager = CLLocationManager()
    
    var prayerTimes: [PrayerTimeModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var userLocation: CLLocationCoordinate2D! {
        didSet {
            getPrayerTimes(coordinates: userLocation)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        startLocation()
    }

}

// MARK: - Actions

extension PrayerTimesViewController {
    @IBAction func refreshTable(sender: AnyObject?) {
        prayerTimes.removeAll()
        self.tableView.reloadData()
        startLocation()
    }
}

// MARK: - Helpers

extension PrayerTimesViewController {
    func startLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func configurePrayerTimes() -> PrayTime {
        let prayTimes = PrayTime()
        prayTimes.setTimeFormat(Int32(PrayTime().time12))
        prayTimes.setCalcMethod(Int32(PrayTime().jafari))
        
        return prayTimes
    }
    
    func getPrayerTimes(coordinates: CLLocationCoordinate2D) {
        let dateComponents = Calendar(identifier: .gregorian).dateComponents(in: TimeZone.current, from: Date())
        
        let prayerTimeNames = PrayTime().timeNames as AnyObject as! [String]
        
        let prayerTimeTimes = configurePrayerTimes().getPrayerTimes(dateComponents, andLatitude: coordinates.latitude, andLongitude: coordinates.longitude, andtimeZone: PrayTime().getZone()) as AnyObject as! [String]
        
        self.prayerTimes = zip(prayerTimeNames, prayerTimeTimes).map {
            PrayerTimeModel(name: $0, time: $1)
        }
    }
}

// MARK: - Table view

extension PrayerTimesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerTimes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prayTimeCell", for: indexPath)
        let prayTime = prayerTimes[indexPath.row]
        
        cell.textLabel?.text = "\(prayTime.name)"
        cell.detailTextLabel?.text = "\(prayTime.time)"

        return cell
    }
}

// MARK: - CLLocationManager Delegates

extension PrayerTimesViewController {
    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            let alertController = UIAlertController(
                title: "Location Access Disabled",
                message: "In order to get prayer times for your location, this app needs to access your location.",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(openAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userCoordinates = manager.location?.coordinate {
            self.userLocation = userCoordinates
            print("user location: \(userCoordinates)")
        } else {
            let alertCtrl = UIAlertController(
                title: "Could not get your location.",
                message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertCtrl.addAction(cancelAction)
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                self.startLocation()
            }
            alertCtrl.addAction(tryAgainAction)
            present(alertCtrl, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // FIXME: - error handling...
    }
}


