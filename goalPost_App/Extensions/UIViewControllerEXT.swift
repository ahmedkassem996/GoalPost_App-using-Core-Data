//
//  UIViewControllerEXT.swift
//  goalPost_App
//
//  Created by AHMED on 1/26/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

extension UIViewController{
  func presentDetail(_ viewcontrollerToPresent: UIViewController){
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    self.view.window?.layer.add(transition, forKey: kCATransition)
    
    present(viewcontrollerToPresent, animated: true, completion: nil)
  }
  
  func presentSecondarydetail(_ viewControllerToPresent: UIViewController){
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    
    guard let presentedViewController = presentedViewController else{return}
    
    presentedViewController.dismiss(animated: false) {
      self.view.window?.layer.add(transition, forKey: kCATransition)
      self.present(viewControllerToPresent, animated: false, completion:  nil)
    }
  }
  
  func dismissDetail(){
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    self.view.window?.layer.add(transition, forKey: kCATransition)
    
    dismiss(animated: true, completion: nil)
    
  }
}




