//
//  DisplayViewController.swift
//  PickerView
//
//  Created by Tatiana Looby on 12/02/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pickerViewData = [NSManagedObject]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PickerViewData")
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            pickerViewData = results as! [NSManagedObject]
            
        } catch let error as NSError {
            
            print("Fetching Error: \(error.userInfo)")
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PickerViewCustomCell
        
        let myData = pickerViewData[indexPath.row]
        cell.classNameLabel.text = myData.value(forKey: "nameOfClass") as! String?
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.white
            cell.classNameLabel.textColor = UIColor.gray
        } else {
            cell.backgroundColor = UIColor.gray
            cell.classNameLabel.textColor = UIColor.white
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Delete row from the entity
        if editingStyle == .delete {
            let cell = pickerViewData[indexPath.row]
            context.delete(cell)
            appDelegate.saveContext()
            
            // Fetch updated data
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PickerViewData")
            
            do {
                let results = try managedContext.fetch(fetchRequest)
                pickerViewData = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Fetching Error: \(error.userInfo)")
            }
            
        }
        
        // Reload table
        self.tableView.reloadData()
    }


    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "fromDisplayVCToEnterVC", sender: self)
        
    }
    @IBAction func pickerViewTapped(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "fromDisplayVCToPickerVC", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
