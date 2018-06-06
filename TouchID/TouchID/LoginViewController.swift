//
//  LoginViewController.swift
//  TouchID
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit
import LocalAuthentication

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
    
    loginView.isHidden = true
    authenticateWithBiometric()
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
  
  @IBAction func authenticateWithPassword() {
    if emailTextField.text == "jTanG" && passwordTextField.text == "nincapoop" {
      performSegue(withIdentifier: "showHomeScreen", sender: nil)
    } else {
      // Shake login form to indicate incorrect credentials.
      loginView.transform = CGAffineTransform(translationX: 25, y: 0)
      UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
        self.loginView.transform = CGAffineTransform.identity
      }, completion: nil)
    }
  }
  
  func authenticateWithBiometric() {
    // Get the local authentication context.
    let localAuthContext = LAContext()
    let reasonText = "Authentication is required to sign in"
    var authError: NSError?
    
    if !localAuthContext.canEvaluatePolicy(
      .deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      if let error = authError {
        print(error.localizedDescription)
      }
      
      // Display the login dialog when TouchID is not available.
      showLoginDialog()
      
      return
    }
    
    // Perform the biometric authentication
    localAuthContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonText) { (success, error) in
      if !success {
        if let error = error {
          switch error {
          case LAError.authenticationFailed:
            print("Authentication failed")
          case LAError.passcodeNotSet:
            print("Passcode not set")
          case LAError.systemCancel:
            print("Authentication was cancelled by the system")
          case LAError.userCancel:
            print("Authentication was cancelled by the user")
          case LAError.biometryNotEnrolled:
            print("Authentication could not start as user has not enrolled in either Touch ID or Face ID")
          case LAError.biometryNotAvailable:
            print("Authentication could not start because Touch ID or Face ID is not available")
          case LAError.userFallback:
            print("User tapped the fallback button")
          default:
            print(error.localizedDescription)
          }
          
          // Fallback to password authentication
          OperationQueue.main.addOperation {
            self.showLoginDialog()
          }
        }
      } else {
        OperationQueue.main.addOperation {
          self.performSegue(withIdentifier: "showHomeScreen", sender: nil)
        }
      }
    }
  }
  
}
