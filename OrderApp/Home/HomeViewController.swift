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
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        retrieveData()
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
            for data in results as! [NSManagedObject]{
                print("full: \(data.value(forKey: "fullName") ?? "")")
            }
        }
        catch{
            print("failed")
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
