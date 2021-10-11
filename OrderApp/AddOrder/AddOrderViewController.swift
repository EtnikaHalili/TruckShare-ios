//
//  AddOrderViewController.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import UIKit
import CoreData

class AddOrderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var productNameTextField: TextField!
    @IBOutlet weak var productPriceTextField: TextField!
    @IBOutlet weak var productWeightTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var deliveryAddressTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        // Do any additional setup after loading the view.
    }
    
    //Functions
    func setupTextFields(){
        productNameTextField.delegate = self
        productPriceTextField.delegate = self
        productWeightTextField.delegate = self
        addressTextField.delegate = self
        deliveryAddressTextField.delegate = self
    }
    
    func addProduct(){
        //Validate fields
        guard let prodName = productNameTextField.text, !prodName.isEmpty else {
            self.productNameTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty product name." )
            return
        }
        guard let prodPrice = productPriceTextField.text, !prodPrice.isEmpty else {
            self.productPriceTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty price." )
            return
        }
        guard let weight = productWeightTextField.text, !weight.isEmpty else {
            self.productWeightTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty weight.")
            return
        }
        guard let address = addressTextField.text, !address.isEmpty else {
            self.addressTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty address.")
            return
        }
        guard let deliveryAddress = deliveryAddressTextField.text, !deliveryAddress.isEmpty else {
            self.deliveryAddressTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty address.")
            return
        }
        //add data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContex = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Products", in: managedContex)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContex)
        user.setValue(prodName, forKey: "prodName")
        user.setValue(prodPrice, forKey: "prodPrice")
        user.setValue(weight, forKey: "prodWeight")
        user.setValue(address, forKey: "address")
        user.setValue(deliveryAddress, forKey: "deliveryAddress")
        
        do {
            try managedContex.save()
            print("data saved")
            self.dismiss(animated: true, completion: nil)
        }
        catch let error as NSError{
            print("Couldnot save: \(error), \(error.userInfo)")
        }
    }
    
    //IBActions
    @IBAction func xButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        addProduct()
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
