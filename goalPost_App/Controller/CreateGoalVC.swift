//
//  CreateGoalVC.swift
//  goalPost_App
//
//  Created by AHMED on 1/26/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var goalTextview: UITextView!
  @IBOutlet weak var shortTermBtn: UIButton!
  @IBOutlet weak var longTermBtn: UIButton!
  @IBOutlet weak var nextBtn: UIButton!
  
  var goaltype: GoalType = .shortTerm
  
    override func viewDidLoad() {
        super.viewDidLoad()
      nextBtn.bindToKeyboard()
      shortTermBtn.setSelectedColor()
      longTermBtn.setDeselectedcolor()
      goalTextview.delegate = self
      

    }

  @IBAction func shortTermBtnWasPressed(_ sender: Any) {
    goaltype = .shortTerm
    shortTermBtn.setSelectedColor()
    longTermBtn.setDeselectedcolor()
  }
  
  @IBAction func longTermBtnWasPressed(_ sender: Any) {
    goaltype = .longTerm
    longTermBtn.setSelectedColor()
    shortTermBtn.setDeselectedcolor()
  }
  
  @IBAction func nextBtnWasPressed(_ sender: Any) {
    if goalTextview.text != "" && goalTextview.text != "What is your goal?"{
      guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
      finishGoalVC.initData(description: goalTextview.text, type: goaltype)
      presentingViewController?.presentSecondarydetail(finishGoalVC)
    }
  }
  
  @IBAction func backBtnWasPressed(_ sender: Any) {
    dismissDetail()
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    goalTextview.text = ""
    goalTextview.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  }
  
}
