//
//  LoginViewController.swift
//  TouchID
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var loginView: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  private var imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Randomly pick an image
    let selectedImageIndex = Int(arc4random_uniform(5))
    
    // Apply blurring effect
    backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    showLoginDialog()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Helper methods
  
  func showLoginDialog() {
    // Move the login view off screen
    loginView.isHidden = false
    loginView.transform = CGAffineTransform(translationX: 0, y: -700)
    
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
      
      self.loginView.transform = CGAffineTransform.identity
      
    }, completion: nil)
    
  }
  
}
