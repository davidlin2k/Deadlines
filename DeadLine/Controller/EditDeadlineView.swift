//
//  EditDeadlineView.swift
//  DeadLine
//
//  Created by David Lin on 2022-09-23.
//

import UIKit
import RealmSwift

class EditDeadlineView: UIViewController {
    let realm = try! Realm()
    
    var deadline: Deadline?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (deadline != nil) {
            datePicker.setDate(deadline!.endTime, animated: false)
            titleTextField.text = deadline?.title
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if (deadline != nil) {
            try! realm.write {
                deadline?.endTime = datePicker.date
                deadline?.title = titleTextField.text ?? ""
            }
        }
        else {
            let startDate = Date()
            let dueDate = datePicker.date
            guard let title = titleTextField.text else { return }
            
            let deadline = Deadline(startTime: startDate, endTime: dueDate, title: title)
            
            try! realm.write {
                realm.add(deadline)
            }
        }
        
        self.performSegue(withIdentifier: "unwindAfterSave", sender: nil)
    }
}
