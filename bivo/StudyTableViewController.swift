//
//  StudyTableViewController.swift
//  bivo
//
//  Created by vamsi on 5/8/20.
//  Copyright © 2020 com.vamsi. All rights reserved.
//

import UIKit
import CoreData
class StudyTableViewController: UITableViewController {

    var studies = [Study]()
    var user = [NSManagedObject]()
    var orders = [OrderModel]()
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresher
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Order")
        /*
         var university : String;
            var research_type : String;
            var price : String;
            var audience: [String];
            var bio: String;
            var serverAddress: String;
            var query: [String];
         */
        //3
        do {
            user = try managedContext.fetch(fetchRequest)
            for i in 0..<user.count {
                let university = user[i].value(forKeyPath: "university") as? String
                let research_type = user[i].value(forKeyPath: "research_type") as? String
                let price = user[i].value(forKeyPath: "price") as? String//String(study.coin_val)
                let bio = user[i].value(forKeyPath: "bio") as? String
                let query = user[i].value(forKeyPath: "query") as? [String]
                let audience = user[i].value(forKeyPath: "audience") as? [String: String]
                let serverAddress = user[i].value(forKeyPath: "serverAddress") as? String
                orders.append(OrderModel(university: university!, research_type: research_type!, price: price!, audience: audience!, bio: bio!, serverAddress: serverAddress!, query: query!))
                
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    @objc func refresh() {
        requestData() { (order_model) in
          // Do something with the data the completion handler returns
            self.orders = order_model.orders
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.refresher.endRefreshing()

            }
        }
        
    }
    func requestData(completionHandler: @escaping (OrderModels) -> Void) {
        print("Refreshing")
        let url = URL(string: "https://ee1cab2e.ngrok.io/orders")!;
        let task = URLSession.shared.dataTask(with: url , completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          print("made request...")
            print()
          print("yuh request...")

          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }
            if let data = data,
                let responseOrders = try? JSONDecoder().decode(OrderModels.self, from: data) {
//                self.orders = responseOrders.orders;
                let obj = OrderModels(orders: [OrderModel()])
                completionHandler(responseOrders)
                }
            

        })
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudyTableViewCell", for: indexPath) as? StudyTableViewCell else {
            fatalError("The dequeued cell is not an instance of StudyTableViewCell.")
        }
        
        cell.university!.text = orders[indexPath.item].university as? String
        cell.research_type!.text = orders[indexPath.item].research_type as? String
        cell.coin_value!.text = orders[indexPath.item].price as? String//String(study.coin_val)
        // Configure the cell...

        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
}
