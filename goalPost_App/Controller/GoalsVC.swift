//
//  GoalsVC.swift
//  goalPost_App
//
//  Created by AHMED on 1/22/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import CoreData

let appDelegata = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
  
  var goals: [Goal] = []

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isHidden = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchCoreDataObject()
    tableView.reloadData()
  }
  
  func fetchCoreDataObject(){
    self.fetch { (completed) in
      if completed{
        if goals.count >= 1{
          tableView.isHidden = false
          
        }else{
          tableView.isHidden = true
        }
      }
    }
  }

  @IBAction func addGoalBtnWasPressed(_ sender: Any) {
    guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else{return}
    presentDetail(createGoalVC)
  }
  
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return goals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let goal = goals[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else{return UITableViewCell()}
    cell.configureCell(goal: goal)
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteaction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
      self.removeGoal(atIndex: indexPath)
      self.fetchCoreDataObject()
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    let addAction  = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
      self.setProgress(atIndex: indexPath)
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    deleteaction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
    
    return[deleteaction,addAction]
  }
}

extension GoalsVC{
  func setProgress(atIndex indexPath: IndexPath){
     guard let managedContext = appDelegata?.persistentContainer.viewContext else{return}
    let chosenGoal = goals[indexPath.row]
    
    if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
      chosenGoal.goalProgress = chosenGoal.goalProgress + 1
    }else{
      return
    }
    
    do{
      try managedContext.save()
      print("successfully set progress")
    }catch{
      debugPrint("could not set progress: \(error.localizedDescription)")
    }
  }
  
  func removeGoal(atIndex indexPath: IndexPath){
    guard let managedContext = appDelegata?.persistentContainer.viewContext else{return}
    
    managedContext.delete(goals[indexPath.row])
    
    do{
      try managedContext.save()
      print("successfully removed goal")
    }catch{
      debugPrint("could not remove: \(error.localizedDescription)")
    }
  }
  
  func fetch(completion:(_ completion: Bool) ->()){
    guard let managedContext = appDelegata?.persistentContainer.viewContext else{return}
    
    let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
    
    do{
      goals = try managedContext.fetch(fetchRequest)
      print("Successfully fetched data.")
      completion(true)
    }catch{
      debugPrint("could not fetch:\(error.localizedDescription)")
      completion(false)
    }
    
  }
}


