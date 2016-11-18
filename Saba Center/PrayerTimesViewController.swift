//
//  PrayerTimesViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/11/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

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
            reverseGeocoding(latitude: userLocation.latitude, longitude: userLocation.longitude)
        }
    }
    
    var locationToDisplay: String?
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.textLabel?.textAlignment = .center
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        let dateString = formatter.string(from: Date())
        
        let islamicDateComponents = Calendar(identifier: .islamicTabular).dateComponents(in: TimeZone.current, from: Date())
        
        var islamicDate: String? = nil
        
        if let day = islamicDateComponents.day, let month = islamicDateComponents.month, let year = islamicDateComponents.year, let islamicMonth = IslamicMonths(rawValue: month)?.string {
            islamicDate = "\(islamicMonth) \(day), \(year)"
        }
        
        let islamicDateString = (islamicDate == nil) ? "" : "\n\(islamicDate!)"
        
        return dateString + islamicDateString
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return locationToDisplay ?? ""
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
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        
        if let userCoordinates = manager.location?.coordinate {
            self.userLocation = userCoordinates
            self.tableView.reloadData()
            print("User Location: \(userCoordinates)")
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
}

// MARK: - Geocoding

extension PrayerTimesViewController {
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            else if let placemarks = placemarks, placemarks.count > 0 {
                self.setLocationAddress(placemarks)
            }
        })
    }
    
    func setLocationAddress(_ placemarks: [CLPlacemark]) {
        let pm = placemarks[0]
        var saveAddress = ""
        if let address = pm.addressDictionary as? [String: AnyObject] {
            let city = (address["City"] as? String) ?? ""
            let state = (address["State"] as? String) ?? ""
            let country = (address["Country"] as? String) ?? ""
            
            if city != "" && state != "" {
                saveAddress = "\(city), \(state)"
            }
            
            if city != "" && state == "" {
                if country != "" {
                    saveAddress = "\(city), \(country)"
                } else {
                    saveAddress = city
                }
            }
            
            if city == "" && state != "" {
                if country != "" {
                    saveAddress = "\(state), \(country)"
                } else {
                    saveAddress = state
                }
            }
            
            if city == "" && state == "" {
                if country != "" {
                    saveAddress = country
                }
            }
        }
        
        performUIUpdatesOnMain {
            self.locationToDisplay = saveAddress
            self.tableView.reloadData()
        }
    }
}

