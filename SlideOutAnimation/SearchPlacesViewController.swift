//
//  SearchPlacesViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 14/10/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Contacts

class SearchPlacesViewController: UIViewController, UISearchBarDelegate, UINavigationControllerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func searchButtonPressed(_ sender: Any) {
        let searchViewController = UISearchController(searchResultsController: nil)
        searchViewController.searchBar.delegate = self;
        present(searchViewController, animated: true, completion: nil)
            }
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        navigationController?.delegate = self
        self.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLocationAuthorizationStatus()
    }
    let customNavigationViewController = CustomNavigationController()
    let customInteractionViewController = CustomInteractionController()
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push
        {
            customInteractionViewController.attachToViewController(viewController: toVC)
        }
        if operation == .pop
        {
            self.navigationController?.delegate = nil;
        }
        customNavigationViewController.reverse = (operation == .pop)
        return customNavigationViewController as UIViewControllerAnimatedTransitioning
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = mapView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        mapView.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if(response == nil)
            {
                print("ERROR")
            }
            else
            {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let lattitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(lattitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                let coordinate  = CLLocationCoordinate2DMake(lattitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated:true)
                
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        let identifier = "Annotation"
        var annotationView: MKMarkerAnnotationView
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequedView.annotation = annotation
            annotationView = dequedView
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as? MKPointAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let mapItem : MKMapItem
        let addressDict = [CNPostalAddressStreetKey: location?.title]
        let placemark = MKPlacemark(coordinate: (location?.coordinate)!, addressDictionary: addressDict as [String : Any])
        mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location?.title ?? ""
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}
