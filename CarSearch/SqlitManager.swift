//
//  SqlitManager.swift
//  CarSearch
//
//  Created by Mac on 29/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import SQLite3

class SqlitManager {
    
   static let sharedInstance = SqlitManager()
    
   private init() { }
    
    var db: OpaquePointer?
    
    
    func prepareDatabaseFile() -> String {
        let fileName: String = "carbooking2.sql"

        let fileManager:FileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        let documentUrl = directory.appendingPathComponent(fileName)
        let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(fileName)

        // here check if file already exists on simulator
        if fileManager.fileExists(atPath: (documentUrl.path)) {
            print("document file exists!")
            return documentUrl.path
        }
        else if fileManager.fileExists(atPath: (bundleUrl?.path)!) {
            print("document file does not exist, copy from bundle!")
           try? fileManager.copyItem(at:bundleUrl!, to:documentUrl)

            
        }

        return documentUrl.path
    }
        func getConnectionQuery() -> Bool{
//
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            .appendingPathComponent("carbooking2.sql")

        if sqlite3_open(prepareDatabaseFile(), &db) != SQLITE_OK {
            print("error opening database")
            return false
        }
        return true
    }
}
