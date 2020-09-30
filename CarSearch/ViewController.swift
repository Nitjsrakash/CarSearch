//
//  ViewController.swift
//  CarSearch
//
//  Created by Mac on 29/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftyGif
import UIKit
import SQLite3


class ViewController: UIViewController,DropDownViewControllerDelegate {
    
 let logoAnimationView = LogoAnimationView()
    
    @IBOutlet weak var carBrand: UIButton!
    @IBOutlet weak var carMake: UIButton!
    @IBOutlet weak var carModel: UIButton!
    @IBOutlet weak var carYear: UIButton!
    @IBOutlet weak var carMilage: UIButton!
    @IBOutlet weak var carRegion: UIButton!
    @IBOutlet weak var carDealer: UIButton!
   
    var milageValue: String?
    var Milage: String?
    var Make: String?
    var Model:String?
    var Dealership: String?
    var brand: String?
    var queryString : String?

   
    
    override func viewDidLoad() {
              super.viewDidLoad()
              view.addSubview(logoAnimationView)
              logoAnimationView.pinEdgesToSuperView()
             logoAnimationView.logoGifImageView.delegate = self
             setDropDownImage()
          }
          
          override func viewDidAppear(_ animated: Bool) {
              super.viewDidAppear(animated)
              logoAnimationView.logoGifImageView.startAnimatingGif()
          }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    func setDropDownImage(){
        carBrand.setRightButtonImage()
        carMake.setRightButtonImage()
        carModel.setRightButtonImage()
        carYear.setRightButtonImage()
        carMilage.setRightButtonImage()
        carRegion.setRightButtonImage()
        carDealer.setRightButtonImage()
    }
    
    @IBAction func carAttributeButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownViewController") as! DropDownViewController
        switch sender.tag {
        case 0:
            if brand == nil{
                //isAlertElse(title: "Car Brand", message: "Select Car Brand")
                isAlertElse(title: "ماركة السيارة", message: "اختر ماركة السيارة")
            }
            else{
            vc.carBrandName = "brand ==" + "\"" + brand! + "\""
            vc.carvalue = "make_car"
            vc.index = sender.tag
            }
        case 1:
            if brand == nil{
                //isAlertElse(title: "Car Brand", message: "Select Car Brand")
                isAlertElse(title: "ماركة السيارة", message: "اختر ماركة السيارة")
            }
            else{
            vc.carBrandName = "brand ==" + "\"" + brand! + "\""
            vc.carvalue = "model"
            vc.index = sender.tag
            }
        case 2:
            vc.index = sender.tag
        case 3:
             vc.index = sender.tag
        case 4:
             vc.index = sender.tag
        case 5:
            vc.index = sender.tag
        case 6:
            vc.carvalue = "brand"
            vc.index = sender.tag
            
        default:
            return
        }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func carData(data: [String : Any]) {
        let carIndex = data["tag"]  as? Int
        switch (carIndex){
        case 0:
            carMake.setTitle(data["value"]! as? String, for: .normal)
            Make =  data["value"]! as? String
        case 1:
            carModel.setTitle(data["value"]! as? String, for: .normal)
            Model = data["value"]! as? String
        case 2:
            carYear.setTitle(data["value"]! as? String, for: .normal)
        case 3:
            carMilage.setTitle(data["value"]! as? String, for: .normal)
            Milage = data["value"]! as? String
        case 4:
            carDealer.setTitle(data["value"]! as? String, for: .normal)
            Dealership = data["value"]! as? String
        case 5:
            carRegion.setTitle(data["value"]! as? String, for: .normal)
        case 6:
            carBrand.setTitle(data["value"]! as? String, for: .normal)
            brand = data["value"]! as? String
        default:
            return
        }
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if brand == nil || carMake == nil || carModel == nil || Milage == nil{
            // isAlertElse(title:"Error", message:"Please Select All Car Field")
            isAlertElse(title: "خطأ", message: "يرجى اختيار جميع مجال السيارات")
            return
        }
        
//        if  (Milage == nil || brand == nil) {
//            //isAlertElse(title:"عدد الأميال", message:"Hello Brand ")
//            isAlertElse(title:"عدد الأميال", message:"سيلت من الأميال")
//                   return
//               }
//       else if Make == nil && Dealership == nil && Model == nil
//        {
//            isAlertElse(title: "خطأ", message:"اختر حقلًا واحدًا من صنع الطراز والطراز")
//            return
//        }
        
    let milageString = "`" + Milage! + "_milage" + "`"
        
        if  Make != nil && brand != nil && Model != nil {
                 queryString = "brand == " + "\"" + brand! + "\"" + " and make_car == " + "\"" + Make! + "\"" + " and model == " + "\"" + Model! + "\""
             }
//
//        else  if Make != nil && Model != nil{
//                               queryString = "make_car == " + "\"" + Make! + "\"" + "and  model == " +   "\"" + Model! + "\""
//                           }
//        else  if Dealership != nil && Model != nil {
//                        queryString = "dealership == " + "\"" + Dealership! + "\"" + "and  model == " +   "\"" + Model! + "\""
//                    }
//        else if  Make != nil && Dealership != nil {
//                 queryString = "dealership == " + "\"" + Dealership! + "\"" + "and make_car == " + "\"" + Make! + "\""
//             }
//        else if Make != nil{
//                      queryString = "make_car == " + "\"" + Make! + "\""
//                  }
//        else if Model != nil {
//                      queryString = "model == " + "\"" + Model! + "\""
//                  }
//        else if Dealership != nil {
//                      queryString = "dealership == " +   "\"" + Dealership! + "\""
//                  }
        
        // Search Milage Query Execute
        
        showMilage(fieldValue: milageString, fieldQuery: queryString!)
        
        //  Milage Value Checked
        
        
        if milageValue != nil {
                  isAlertIf(title: "السعر", message: milageValue!)
            }
       else {
                isAlertIf(title: "السعر", message: "لا مخارج السعر")
            }
    }
    
    func isAlertIf(title:String , message:String){
        let alert = UIAlertController(title: "\(title)", message: "\(message) ", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.queryString = ""
            NSLog("OK Pressed")
        }
               alert.addAction(okAction)
                   self.present(alert, animated: true)
    }
    
    func isAlertElse(title:String , message:String){
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func showMilage(fieldValue:String,fieldQuery:String) {
//        if  Milage == nil {
//            print("Selcet of Milage")
//            isAlertElse(title:"عدد الأميال", message:"سيلت من الأميال")
//            return
//        }
//        else {
//            if  Make != nil && Dealership != nil && Model != nil{
//                queryString = "dealership == " + "\"" + Dealership! + "\"" + " and make_car == " + "\"" + Make! + "\"" + " and model == " + "\"" + Model! + "\""
//            }
//
//              else  if Make != nil && Model != nil{
//                              queryString = "make_car == " + "\"" + Make! + "\"" + "and  model == " +   "\"" + Model! + "\""
//                          }
//              else  if Dealership != nil && Model != nil {
//                       queryString = "dealership == " + "\"" + Dealership! + "\"" + "and  model == " +   "\"" + Model! + "\""
//                   }
//              else if  Make != nil && Dealership != nil {
//                queryString = "dealership == " + "\"" + Dealership! + "\"" + "and make_car == " + "\"" + Make! + "\""
//            }
//            else if Make != nil{
//                     queryString = "make_car == " + "\"" + Make! + "\""
//                 }
//            else if Model != nil {
//                     queryString = "model == " + "\"" + Model! + "\""
//                 }
//            else if Dealership != nil {
//                     queryString = "dealership == " +   "\"" + Dealership! + "\""
//                 }
//        }
//
        if SqlitManager.sharedInstance.getConnectionQuery(){
            milageValue = nil
            let query = String(format: "SELECT %@  FROM carsearch where %@  ",fieldValue ,fieldQuery)
            
            print(query)
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
                print(value)
                if value != ""{
                    milageValue = String(describing: value)
                }
            }
        }
    }
    
}
extension UIButton {
    func setRightButtonImage() {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: screenWidth - 70)
   }
}

extension ViewController: SwiftyGifDelegate {
func gifDidStop(sender: UIImageView) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.logoAnimationView.isHidden = true
        }
    }
}
