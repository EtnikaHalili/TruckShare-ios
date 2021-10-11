//
//  AddDestinationViewController.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import UIKit
import CoreData

class AddDestinationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullNameTextField: TextField!
    @IBOutlet weak var destinationAddressTextField: TextField!
    @IBOutlet weak var dateTextField: TextField!
    @IBOutlet weak var timeTextField: TextField!
    @IBOutlet weak var conatactTextField: TextField!
    
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupDatePicker()
        //retrieveData()
        // Do any additional setup after loading the view.
    }
    
    //Functions
    func setupTextFields(){
        fullNameTextField.delegate = self
        destinationAddressTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
        conatactTextField.delegate = self
    }
    func setupDatePicker(){
        dateTextField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    func addDriver(){
        //Validate fields
        guard let fullName = fullNameTextField.text, !fullName.isEmpty else {
            self.fullNameTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty full name." )
            return
        }
        guard let address = destinationAddressTextField.text, !address.isEmpty else {
            self.destinationAddressTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty price." )
            return
        }
        guard let date = dateTextField.text, !date.isEmpty else {
            self.dateTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty weight.")
            return
        }
        guard let time = timeTextField.text, !address.isEmpty else {
            self.timeTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty address.")
            return
        }
        guard let contact = conatactTextField.text, !contact.isEmpty else {
            self.conatactTextField.becomeFirstResponder()
            self.showAlertWith(title: "Alert", message: "Empty address.")
            return
        }
        //add data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContex = appDelegate.persistentContainer.viewContext
        
        if let driverEntitity = NSEntityDescription.entity(forEntityName: "Driver", in: managedContex){
        
            let driver = NSManagedObject(entity: driverEntitity, insertInto: managedContex)
            driver.setValue(fullName, forKey: "fullName")
            driver.setValue(address, forKey: "address")
            driver.setValue(date, forKey: "date")
            driver.setValue(time, forKey: "time")
            driver.setValue(contact, forKey: "contact")
            
            do {
                try managedContex.save()
                print("data saved")
                NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            catch let error as NSError{
                print("Couldnot save: \(error), \(error.userInfo)")
            }
        }
    }
//    func retrieveData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let managedContex = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Drivers")
//        do{
//            let results = try managedContex.fetch(request)
//            for data in results as! [NSManagedObject]{
//                print("driver details: \(data.value(forKey: "fullName") ?? "")")
//            }
//        }
//        catch{
//            print("failed")
//        }
//    }
    
    //IBActions
    @IBAction func xButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        addDriver()
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
