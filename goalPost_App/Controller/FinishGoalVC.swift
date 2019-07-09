//
//  FinishGoalVC.swift
//  goalPost_App
//
//  Created by AHMED on 1/26/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var createGoalBtn: UIButton!
  @IBOutlet weak var pointstextField: UITextField!
  
  var goalDescription: String!
  var goalType: GoalType!
  
  func initData(description: String, type: GoalType){
    self.goalDescription = description
    self.goalType = type
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
      createGoalBtn.bindToKeyboard()
    pointstextField.delegate = self
    

    }
  @IBAction func createGoalBtnWasPressed(_ sender: Any) {
    // pass data into core data goal model
    if pointstextField.text != ""{
      self.save { (complete) in
        if complete{
          self.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  @IBAction func createBackBtnWasPressed(_ sender: Any) {
    dismissDetail()
  }

  func save(completion:@escaping (_ finished: Bool) -> ()){
    guard let managedContext = appDelegata?.persistentContainer.viewContext else{return}
    let goal = Goal(context: managedContext)
    
    goal.goalDescription = goalDescription
    goal.goalType = goalType.rawValue
    goal.goalCompletionValue = Int32(pointstextField.text!)!
    goal.goalProgress = Int32(0)
    
    do{
      try managedContext.save()
      print("successfully saved data")
      completion(true)
    }
      catch{
        debugPrint("couldn't save:\(error.localizedDescription)")
        completion(false)
        
      }
    }
  }
  

