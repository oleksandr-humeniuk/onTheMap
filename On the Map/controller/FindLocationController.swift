//
//  FindLocationController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/7/20.
//

import UIKit
import CoreLocation

class FindLocationController: UIViewController {
    struct Strings {
        fileprivate static let LOCATION_ERROR_TITLE = "Location Error"
        fileprivate static let URL_ERROR_TITLE = "Url Error"
        fileprivate static let URL_ERROR_MESSAGE = "Url cannot be empty"
    }
    
    @IBOutlet weak var locationTextField: UdacityTextField!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var urlTextField: UdacityTextField!
    @IBOutlet weak var findButton: UdacityButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgress(false)
    }
    
    
    @IBAction func onFindClicked(_ sender: Any) {
        let url = urlTextField.text ?? ""
        guard !url.isEmpty else {
            self.showAlert(title: Strings.URL_ERROR_TITLE, message: Strings.URL_ERROR_MESSAGE)
            return
        }
        
        let location = locationTextField.text ?? ""
        showProgress(true)
        FindLocationInteractor.find(location: location,completion: {clLocation,error in
            self.showProgress(false)
            guard let clLocation = clLocation else{
                self.showAlert(title: Strings.LOCATION_ERROR_TITLE, message: error!.localizedDescription)
                return
            }
            self.navigateToConfrimLocation(mapName: location, location:clLocation, url: url)
        })
    }
    
    @IBAction func onCancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func navigateToConfrimLocation(mapName:String, location:CLLocation,url:String) {
        let controller = storyboard?.instantiateViewController(withIdentifier: AddLocationController.IDENTIFIER) as! AddLocationController
        controller.url = url
        controller.mapName = mapName
        controller.cllLocation = location
        present(controller, animated: true, completion: nil)
    }
    
    private func showProgress(_ progress:Bool){
        progressView.isHidden = !progress
        findButton.isEnabled = !progress
        locationTextField.isEnabled = !progress
        urlTextField.isEnabled = !progress
    }
}
