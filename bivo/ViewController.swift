//
//  ViewController.swift
//  bivo
//
//  Created by vamsi on 5/8/20.
//  Copyright © 2020 com.vamsi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    let officialPIN = "1234"
    
    @IBOutlet weak var pin: UITextField!
    override func viewDidLoad() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        // 2
//        let person = Demographics(context: managedContext)
//        let order = Order(context: managedContext)
//        let order2 = Order(context: managedContext)

        let data = Data(context: managedContext)
        data.setValue([120,100,90,80,63],forKeyPath: "avg_heartrate")
        data.setValue([100,97.6,100.3,98.4,97.5],forKeyPath: "temperature")
        data.setValue([3000,4000,3333,6000,2500],forKeyPath: "steps")
        data.setValue([140,70,110,180,197],forKeyPath: "blood_sugar")
        
        var conditions: [String]
        conditions = ["Diabetic","Depression"]
        
        // 3
//        person.setValue("13-20", forKeyPath: "age")
//        person.setValue("Male", forKeyPath: "sex")
//        person.setValue("Asian", forKeyPath: "ethnicity")
//        person.setValue(conditions, forKeyPath: "condition")
//
//        order.setValue(["sex": "male"], forKeyPath: "audience")
//        order.setValue(["temperature"], forKeyPath: "query")
//        order.setValue("Emory University", forKeyPath: "university")
//        order.setValue("COVID-19", forKeyPath: "research_type")
//        order.setValue("12", forKeyPath: "price")
//        order.setValue("This is a COVID-19 study you dumb bitch", forKeyPath: "bio")
//        order.setValue("http://localhost:3000/transferData/", forKeyPath: "serverAddress")
//
//        order2.setValue(["sex": "female"], forKeyPath: "audience")
//        order2.setValue(["steps"], forKeyPath: "query")
//        order2.setValue("Georgia Tech", forKeyPath: "university")
//        order2.setValue("COVID-20", forKeyPath: "research_type")
//        order2.setValue("14", forKeyPath: "price")
//        order2.setValue("This is a COVID-19 study you dumb bitch", forKeyPath: "bio")
//        order2.setValue("http://localhost:3000/transferData/", forKeyPath: "serverAddress")
        
        // 4
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPushed(_ sender: Any) {
        let enteredPIN = pin.text
        if(enteredPIN == officialPIN) {
            self.performSegue(withIdentifier: "loginPassed", sender: self)
        }
    }
    

    


}

