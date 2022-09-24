//
//  ViewController.swift
//  DeadLines
//
//  Created by David Lin on 2022-08-31.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    var deadlines: [Deadline] = []
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "DeadLineCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DeadLineCell")
        
        deadlines = realm.objects(Deadline.self).sorted(byKeyPath: "endTime").map{ $0 }
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showDeadlineEditView", sender: nil)
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
        self.deadlines = realm.objects(Deadline.self).sorted(byKeyPath: "endTime").map{ $0 }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDeadlineEditView" && sender != nil) {
            let destination = segue.destination as! EditDeadlineView
            
            destination.deadline = sender as? Deadline
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeadLineCell") as! DeadLineCell
        
        cell.dataModel = deadlines[indexPath.row]
        cell.endTimeLabel.text = cell.dataModel?.getEndTime()
        cell.titleLabel.text = cell.dataModel?.title
        cell.startTimer()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let cell = tableView.cellForRow(at: indexPath) as! DeadLineCell
            cell.stopTimer()
            
            try! realm.write {
                realm.delete(deadlines[indexPath.row])
            }
            
            deadlines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeadLineCell
        
        self.performSegue(withIdentifier: "showDeadlineEditView", sender: cell.dataModel)
    }
}
