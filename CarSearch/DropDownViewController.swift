//
//  DropDownViewController.swift
//  CarSearch
//
//  Created by Mac on 29/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SQLite3


protocol DropDownViewControllerDelegate {
    func carData(data: [String : Any])
}

class DropDownViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate{
    var carvalue: String?
    var index: Int?
    var carBrandName: String?
    var carItem: String?
    var carfiled = [CarFiled]()
    var indexarray = [Int]()
    
    @IBOutlet weak var CarTable: UITableView!
    
    var delegate: DropDownViewControllerDelegate?
    
    let Car1 = [[],[],["2000","2001","2002","2003","2004"],["0","10000","30000","50000","80000","100000","130000","160000","200000"],["سعودي"],
        ["الغربي","وسط","الشرقية"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableList()
    }
    func tableList(){
        if index == 2 || index == 3 || index == 5 || index == 4{
            print(index!)
        }
        else {
            showCarList(fieldValue: carvalue!)
           }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if index == 2 || index == 3 || index == 5{
//            print("2")
//        }
//        else {
//            showCarList(fieldValue: carvalue!)
//           }
//    }
    
    @IBAction func dropdownButtonClosePressed(_ sender: UIButton) {
        if carItem != nil && index != nil{
            var data = [String : Any]()
            data["tag"] = index
            data["value"] = carItem
            self.delegate?.carData(data:data)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        else{
             self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 2 || index == 3 || index == 5 || index == 4{
            return Car1[index!].count
             }
        else
            {
                return carfiled.count
            }

    }
    
    func getArrayfordropDown() -> [String]
    {
        if index == 2 || index == 3 || index == 5 || index == 4{
           return Car1[index!]
            }
        else
            {
                return [""]
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = CarTable.dequeueReusableCell(withIdentifier: "carCell")
        if indexarray.count > 0 && indexarray.contains(indexPath.row){
            cell?.accessoryType = .checkmark
        }
         else{
            cell?.accessoryType = .none
            }
        let array = getArrayfordropDown()
        if index == 2 || index == 5 || index == 3 || index == 4{
            cell?.textLabel?.text = array[indexPath.row]
            //cell?.textLabel!.textAlignment = NSTextAlignment.right
        }
        else{
             let carIndex = carfiled[indexPath.row]
             cell?.textLabel?.text = carIndex.value
            //cell?.textLabel!.textAlignment = NSTextAlignment.right
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       CarTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let array = getArrayfordropDown()
        indexarray.append(indexPath.row);
        if index == 2 || index == 5 || index == 3 || index == 4{
             carItem = array[indexPath.row]
        }
        else{
            carItem = carfiled[indexPath.row].value
        }
    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        CarTable.cellForRow(at: indexPath)?.accessoryType = .none
        indexarray.removeAll()
    }
   
//
//    func showCarList(fieldValue:String) {
//        if SqlitManager.sharedInstance.getConnectionQuery(){
//
//            let query = String(format: "SELECT %@ FROM carsearch",fieldValue)
//
//            //statement pointer
//            var stmt:OpaquePointer?
//
//            //preparing the query
//            if sqlite3_prepare(SqlitManager.sharedInstance.db, query, -1, &stmt, nil) != SQLITE_OK{
//                let errmsg = String(cString: sqlite3_errmsg(SqlitManager.sharedInstance.db)!)
//                print("error preparing insert: \(errmsg)")
//                return
//            }
//            while(sqlite3_step(stmt) == SQLITE_ROW){
//               let value = String(cString:sqlite3_column_text(stmt,0))
//                if value != ""{
//                  carfiled.append(CarFiled( value: String(describing: value)))
//                }
//            }
//            DispatchQueue.global(qos: .utility).async {
//                DispatchQueue.main.async {
//                    self.CarTable.reloadData()
//
//                }
//            }
//        }
//
//    }

    func showCarList(fieldValue:String){
        DispatchQueue.global(qos: .background).async {
            if SqlitManager.sharedInstance.getConnectionQuery(){
                let query: String?
                if self.carBrandName != nil{

                    query = String(format: "SELECT  distinct(%@) FROM carsearch where %@ ",fieldValue,self.carBrandName!)
                     print(query!)
                }
                else{
                      query = String(format: "SELECT  distinct(%@) FROM carsearch  ",fieldValue)
                }
               // let query = String(format: "SELECT  distinct(%@) FROM carsearch  ",fieldValue)
                   //statement pointer
                   var stmt:OpaquePointer?

                   //preparing the query
                   if sqlite3_prepare(SqlitManager.sharedInstance.db, query, -1, &stmt, nil) != SQLITE_OK{
                       let errmsg = String(cString: sqlite3_errmsg(SqlitManager.sharedInstance.db)!)
                       print("error preparing insert: \(errmsg)")
                       return
                   }
                   while(sqlite3_step(stmt) == SQLITE_ROW){
                      let value = String(cString:sqlite3_column_text(stmt,0))
                   // print(value)
                       if value != ""{
                        self.carfiled.append(CarFiled( value: String(describing: value)))
                       }
                   }
               }
               DispatchQueue.main.async {
                   self.CarTable.reloadData()
               }
           }
       }
}
