//
//  PickerViewController.swift
//  PickerView
//
//  Created by Tatiana Looby on 13/02/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit
import CoreData

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerViewData = [NSManagedObject]()
    
    var chosenRow = 0
    
    @IBOutlet weak var classPickerView: UIPickerView!
    
    @IBOutlet weak var chosenClassNameToDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        classPickerView.delegate = self
        classPickerView.dataSource = self
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
        
        classPickerView.reloadAllComponents()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set up picker view
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerViewTitleForRow = pickerViewData[row]
        return pickerViewTitleForRow.value(forKey: "nameOfClass") as! String?
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set up function to recognise which row was chosen
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenRow = row
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "fromPickerVCToDisplayVC", sender: self)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let pickerViewTitleForRow = pickerViewData[chosenRow]
        chosenClassNameToDisplay.text = pickerViewTitleForRow.value(forKey: "nameOfClass") as! String?
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
