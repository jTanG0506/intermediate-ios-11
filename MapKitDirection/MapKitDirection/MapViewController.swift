//
//  MapViewController.swift
//  MapKitDirection
//
//  Created by Jonathan Tang on 06/04/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var segmentedControl: UISegmentedControl!
  
  var restaurant: Restaurant!
  
  var locationManager = CLLocationManager()
  var currentPlacemark: CLPlacemark?
  var currentTransportType = MKDirectionsTransportType.automobile
  var currentRoute: MKRoute?
  
  @IBAction func showDirection(sender: UIButton) {
    guard let currentPlacemark = currentPlacemark else {
      return
    }
    
    switch segmentedControl.selectedSegmentIndex {
    case 0: currentTransportType = .automobile
    case 1: currentTransportType = .walking
    default: break
    }
    
    segmentedControl.isHidden = false
    
    // Build the direction request
    let directionRequest = MKDirectionsRequest()
    directionRequest.source = MKMapItem.forCurrentLocation()
    directionRequest.destination = MKMapItem(placemark: MKPlacemark(placemark: currentPlacemark))
    directionRequest.transportType = currentTransportType
    
    // Calculate the directions
    let directions = MKDirections(request: directionRequest)
    directions.calculate { (routeResponse, routeError) in
      guard let routeResponse = routeResponse else {
        if let routeError = routeError {
          print("Error: \(routeError)")
        }
        
        return
      }
      
      // Draw the route onto the map
      let route = routeResponse.routes[0]
      self.mapView.removeOverlays(self.mapView.overlays)
      self.mapView.add(route.polyline, level: .aboveRoads)
      
      // Set zoom to perfectly fit the route
      let rect = route.polyline.boundingMapRect
      self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
      
      // Store the route to be passed to RouteTableViewController
      self.currentRoute = route
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Hide the segmented control, until user clicks on Direction button
    segmentedControl.isHidden = true
    
    // Register showDirection as segmentedControl's valueChanged target
    segmentedControl.addTarget(self, action: #selector(showDirection), for: .valueChanged)
    
    // Request for a user's authorisation for location services
    locationManager.requestWhenInUseAuthorization()
    let status = CLLocationManager.authorizationStatus()
    
    if status == CLAuthorizationStatus.authorizedWhenInUse {
      mapView.showsUserLocation = true
    }
    
    // Convert address to coordinate and annotate it on map
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
      if let error = error {
        print(error)
        return
      }
      
      if let placemarks = placemarks {
        // Get the first placemark
        let placemark = placemarks[0]
        self.currentPlacemark = placemark
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.type
        
        if let location = placemark.location {
          annotation.coordinate = location.coordinate
          
          // Display the annotation
          self.mapView.showAnnotations([annotation], animated: true)
          self.mapView.selectAnnotation(annotation, animated: true)
        }
      }
    })
    
    mapView.delegate = self
    
    if #available(iOS 9.0, *) {
      mapView.showsCompass = true
      mapView.showsScale = true
      mapView.showsTraffic = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - MKMapViewDelegate methods
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "MyPin"
    
    if annotation.isKind(of: MKUserLocation.self) {
      return nil
    }
    
    // Reuse the annotation if possible
    var annotationView: MKAnnotationView?
    
    if #available(iOS 11.0, *) {
      var markerAnnotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
      
      if markerAnnotationView == nil {
        markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        markerAnnotationView?.canShowCallout = true
      }
      
      markerAnnotationView?.glyphText = "🍽"
      markerAnnotationView?.markerTintColor = UIColor.orange
      
      annotationView = markerAnnotationView
      
    } else {
      
      var pinAnnotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
      
      if pinAnnotationView == nil {
        pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinAnnotationView?.canShowCallout = true
        pinAnnotationView?.pinTintColor = UIColor.orange
      }
      
      annotationView = pinAnnotationView
    }
    
    let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
    leftIconView.image = UIImage(named: restaurant.image)
    annotationView?.leftCalloutAccessoryView = leftIconView
    annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    performSegue(withIdentifier: "showSteps", sender: view)
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay)
    renderer.strokeColor = currentTransportType == .automobile ? UIColor.purple : UIColor.orange
    renderer.lineWidth = 3.0
    
    return renderer
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showSteps" {
      let routeTableViewController = segue.destination.childViewControllers[0] as! RouteTableViewController
      if let steps = currentRoute?.steps {
        routeTableViewController.routeSteps = steps
      }
    }
  }
  
}
