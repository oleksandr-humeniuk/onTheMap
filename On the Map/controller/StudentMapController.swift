//
//  StudentMapController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import UIKit
import MapKit

fileprivate let MAP_PIN_IDENTIFIER = "pin"

class StudentMapController: UIViewController, MKMapViewDelegate, HomeChildViewController {
    
    @IBOutlet weak var mapView: MKMapView?
    @IBOutlet weak var progressView: UIActivityIndicatorView?
    var annotations = [MKPointAnnotation]()

    
    func updateState(students: [StudentInformation]) {
        mapView?.removeAnnotations(annotations)
        annotations = Array()
        for student in students {
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = student.fullName
            annotation.subtitle = student.mediaURL
            annotations.append(annotation)
        }
        mapView?.addAnnotations(annotations)
    }
    
    func showProgress(_ progress: Bool) {
        progressView?.isHidden = !progress
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: MAP_PIN_IDENTIFIER) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MAP_PIN_IDENTIFIER)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                showUrl(url:toOpen)
            }
        }
    }
}
