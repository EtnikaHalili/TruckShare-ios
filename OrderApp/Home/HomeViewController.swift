//
//  HomeViewController.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.1
//

import UIKit
import CoreData
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //IBOutlets
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var userData : [NSManagedObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        retrieveData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("reloadData"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        retrieveData()
        self.scrollToBottom()
    }
    func setupUI(){
        self.topContainerView.showShadow()
    }
    func setupTableView(){
        self.tableView.register(OrdersTableViewCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    func showAddOrderScreen(){
        let addOrderStoryboard : UIStoryboard = UIStoryboard(name: "AddOrder", bundle:nil)
        let popUp = addOrderStoryboard.instantiateViewController(withIdentifier: "AddOrderViewController") as! AddOrderViewController
        present(popUp, animated: true, completion: nil)
    }
    func showDestinationScreen(){
        let addDestinationStoryboard : UIStoryboard = UIStoryboard(name: "AddDestination", bundle:nil)
        let popUp = addDestinationStoryboard.instantiateViewController(withIdentifier: "AddDestinationViewController") as! AddDestinationViewController
        present(popUp, animated: true, completion: nil)
    }
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContex = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Driver")
        do{
            let results = try managedContex.fetch(request)
            self.userData = results as? [NSManagedObject]
            self.tableView.reloadData()
            for data in results as! [NSManagedObject]{
            }
        }
        catch{
            print("failed")
        }
    }
    func scrollToBottom(){
        guard let userArr = userData else {return}
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: userArr.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    //IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        showDestinationScreen()
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(OrdersTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let userDetails = userData{
            cell.nameLabel.text = "\(userDetails[indexPath.row].value(forKey: "fullName") ?? "")"
            cell.addressLabel.text = "\(userDetails[indexPath.row].value(forKey: "address") ?? "")"
            cell.dateLabel.text = "\(userDetails[indexPath.row].value(forKey: "date") ?? "")"
            cell.timeLabel.text = "\(userDetails[indexPath.row].value(forKey: "time") ?? "")"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        showAddOrderScreen()
    }
}
