//
//  GoalCell.swift
//  goalPost_App
//
//  Created by AHMED on 1/23/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

  @IBOutlet weak var goalDescriptionLbl: UILabel!
  @IBOutlet weak var goalTypeLbl: UILabel!
  @IBOutlet weak var goalProgressLbl: UILabel!
  @IBOutlet weak var completionView: UIView!
  
  
  func configureCell(goal: Goal){
    self.goalDescriptionLbl.text = goal.goalDescription
    self.goalTypeLbl.text = goal.goalType
    self.goalProgressLbl.text = String(describing: goal.goalProgress)
    
    if goal.goalProgress == goal.goalCompletionValue{
      self.completionView.isHidden = false
    }else{
      self.completionView.isHidden = true
    }
    
  }
  
}
