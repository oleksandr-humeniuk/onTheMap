//
//  LoginViewController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import UIKit

fileprivate let HOME_SCREED_SEGUE_ID = "toHomeScreen"
fileprivate let SIGN_UP_URL = "https://auth.udacity.com/sign-up"

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    struct Strings {
        fileprivate static let LOGIN_FAILED_TITLE = "Login failed"
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UdacityButton!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.text = ""
        emailTextField.delegate = self
        passwordTextField.delegate = self
       
        showProgress(false)
    }
    
    @IBAction func onLoginClicked() {
        showProgress(true)
        LoginInteractor.login(username: emailTextField.text ?? "",
                              password: passwordTextField.text ?? "",
                              completion: handleLogin)
    }
    
    @IBAction func onSignUpClicked(_ sender: UIButton) {
        guard let url = URL(string: SIGN_UP_URL ) else { return }
        UIApplication.shared.open(url)
    }
    
    private func handleLogin(response:User?, error:Error?) {
        showProgress(false)
        guard let response = response else {
            showAlert(title: Strings.LOGIN_FAILED_TITLE,message: error!.localizedDescription)
            return
        }
        AppDelegate.user = response
        navigateToHomeScreen()
    }
    
    private func navigateToHomeScreen() {
        performSegue(withIdentifier: HOME_SCREED_SEGUE_ID, sender: nil)
    }
    
    private func showProgress(_ show: Bool){
        progressIndicator.isHidden = !show
        emailTextField.isEnabled = !show
        passwordTextField.isEnabled = !show
        loginButton.isEnabled = !show
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
}
