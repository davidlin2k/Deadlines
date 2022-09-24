//
//  DeadLineCell.swift
//  DeadLine
//
//  Created by David Lin on 2022-09-22.
//

import UIKit

class DeadLineCell: UITableViewCell {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var timer: Timer?
    var dataModel: Deadline?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0/144.0, repeats: true, block: { (timer) in
            DispatchQueue.main.async {
                guard let dataModel = self.dataModel else { return }
                
                if (Date() > dataModel.endTime) {
                    self.timerLabel.text = "Deadline Due!!!"
                    
                    self.backgroundColorView.frame.size.width = self.frame.width
                    self.backgroundColorView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                    
                    timer.invalidate()
                }
                else {
                    self.timerLabel.text = dataModel.getTimeLeft()
                    
                    let timeLeftRatio = ((Date() - dataModel.startTime) / (dataModel.endTime - dataModel.startTime))
                    
                    self.backgroundColorView.frame.size.width = self.frame.width * timeLeftRatio
                    
                    let red = timeLeftRatio
                    let green = 1.0 - timeLeftRatio
                    
                    self.backgroundColorView.backgroundColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
                }
            }
        })
    }
    
    func stopTimer() {
        self.timer?.invalidate()
    }
}
