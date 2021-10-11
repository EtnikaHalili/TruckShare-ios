//
//  SignUpViewController.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullNameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        // Do any additional setup after loading the view.
    }
    
    //IBActions
    @IBAction func singUpButtonPressed(_ sender: Any) {
        addUser()
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Functions
    func setupTextFields(){
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    func navigateToHomeScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    func addUser(){
        //Validate fields
        guard let fullName = fullNameTextField.text, !fullName.isEmpty else {
            self.fullNameTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty full name." )
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            self.emailTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty email." )
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.passwordTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty password.")
            return
        }
        guard let phone = phoneNumberTextField.text, !phone.isEmpty else {
            self.phoneNumberTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty password.")
            return
        }
        
        
        //add data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContex = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContex)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContex)
        user.setValue(fullName, forKey: "fullName")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        user.setValue(phone, forKey: "phoneNumber")
        
        do {
            try managedContex.save()
            navigateToHomeScreen()
        }
        catch let error as NSError{
            print("Couldnot save: \(error), \(error.userInfo)")
        }
    }
    //Move to next textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
