//
//  HomeTabBarController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    @IBAction func onLogoutClicked(_ sender: Any) {
        LogoutInteractor.logout(completion: handleLogout)
    }
    
    @IBAction func onRefreshClicked(_ sender: Any) {
        fetchStudents()
    }
    
    @IBAction func onAddPointClicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }
    
    private func handleLogout(session: LogoutResponse?, error: Error?){
        guard session != nil else {
            showAlert(message: error!.localizedDescription)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func fetchStudents(){
        showProgress(true)
        GetStudentInformationInteractor.get(completion: handleStudentInformation )
    }
    
    private func handleStudentInformation(students: [StudentInformation]?,error: Error?){
        guard let students = students else {
            showAlert(title: "Error", message: error?.localizedDescription)
            return
        }
        populateStudents(students)
        showProgress(false)
    }
    
    private func populateStudents(_ students: [StudentInformation]) {
        guard let viewControllers = self.viewControllers else {
            return
        }
        for childViewController in viewControllers {
            (childViewController as? HomeChildViewController)?.updateState(students: students)
        }
    }
    
    private func showProgress(_ progress:Bool) {
        guard let viewControllers = self.viewControllers else {
            return
        }
        for childViewController in viewControllers {
            (childViewController as? HomeChildViewController)?.showProgress(progress)        }
    }
}
protocol HomeChildViewController {
    func updateState(students:[StudentInformation])
    func showProgress(_ progress:Bool)
}

