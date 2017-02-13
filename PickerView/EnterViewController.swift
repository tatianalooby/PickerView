//
//  EnterViewController.swift
//  PickerView
//
//  Created by Tatiana Looby on 12/02/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit
import CoreData

class EnterViewController: UIViewController {
    
    var pickerViewData = [NSManagedObject]()

    @IBOutlet weak var enterClassNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addClassButtonTapped(_ sender: UIButton) {
        
        // Reference NSManagedObjectContext and save data
        // Labelled myData and can add more other attributes to the entity at a later stage to generate more custom picker views
        
        let className = enterClassNameTextField.text
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PickerViewData", in: context)
        
        let myData = NSManagedObject(entity: entity!, insertInto: context)
        myData.setValue(className, forKey: "nameOfClass")
        pickerViewData.append(myData)
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
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
