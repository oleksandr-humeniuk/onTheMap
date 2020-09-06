//
//  StudentListViewController.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import UIKit

fileprivate let STUDENT_CELL = "studentCell"
class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , HomeChildViewController {
    
    @IBOutlet weak var progressView: UIActivityIndicatorView?
    @IBOutlet weak var tableView: UITableView?
    var students:[StudentInformation] = Array()
    
    func updateState(students: [StudentInformation]) {
        self.students = students
        tableView?.reloadData()
    }
    
    func showProgress(_ progress: Bool) {
        tableView?.isHidden = progress
        progressView?.isHidden = !progress
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STUDENT_CELL) as! StudentCellView
        let student = students[(indexPath as NSIndexPath).row]
        cell.fullNameLabel.text = student.fullName
        cell.mediaLabel.text = student.mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showUrl(url:students[(indexPath as NSIndexPath).row].mediaURL)
    }
}
