//
//  AddLocationController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import UIKit
import CoreLocation
import MapKit

fileprivate let MAP_PIN_IDENTIFIER = "pin"
fileprivate let TO_HOME_SCREEN  = "toHomeScreen"

class AddLocationController: UIViewController , MKMapViewDelegate{
    static let IDENTIFIER = "AddLocation"
    
    struct Strings {
        fileprivate static let UPLOAD_FAILED = "Upload Failed"
    }
    
    var cllLocation: CLLocation!
    var url: String!
    var mapName: String!
    private var user:User {
        return AppDelegate.user!
    }
    @IBOutlet weak var finishButton: UdacityButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgres(false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = cllLocation.coordinate
        annotation.title = user.fullName
        annotation.subtitle = url
        mapView.addAnnotation(annotation)
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
    @IBAction func onFindLocationClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onFinishClicked(_ sender: Any) {
        showProgres(true)
        AddLocationInteractor.add(user: user,
                                  mapName: mapName,
                                  mediaUrl: url,
                                  long: cllLocation.coordinate.longitude,
                                  lat: cllLocation.coordinate.latitude,
                                  completion: handleAddLocationResult)
    }
    
    private func handleAddLocationResult(response: AddLocationResponse?, error: Error?){
        showProgres(false)
        guard response != nil else {
            showAlert(title: Strings.UPLOAD_FAILED, message: error?.localizedDescription)
            return
        }
      performSegue(withIdentifier: TO_HOME_SCREEN, sender: nil)
    }
    
    private func showProgres(_ progress:Bool){
        progressView.isHidden = !progress
        finishButton.isEnabled = !progress
    }
}
