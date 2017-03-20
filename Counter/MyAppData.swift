//
//  MyAppData.swift
//  Counter
//
//  Created by Benjamin Wilcox on 3/2/17.
//  Copyright © 2017 tony. All rights reserved.
//

import Foundation

class MyAppData {
    static let shared = MyAppData()
    var counterTotal = 0
    var dateString = "Last used: never"
    var launchTotal = 0 {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(launchTotal, forKey: launchKey)
        }
    }
    
    let counterKey = "counterKey"
    let dateStringKey = "dateStringKey"
    let launchKey = "launchKey"
    
    /**
     * Read the default data that's already in the system
     */
    private func readDefaultsData() {
        let defaults = UserDefaults.standard
        counterTotal = defaults.integer(forKey: counterKey)
        
        if let s = defaults.object(forKey: dateStringKey) {
            dateString = s as! String
        } else {
            dateString = "Welcome to Counter"
        }
        
        launchTotal = defaults.integer(forKey: launchKey)
    }
    
    private init(){
        print("Created MyAppData instance")
        readDefaultsData()
    }
    
    public func saveDefaultsData() {
        print("Saving to defaults")
        let defaults = UserDefaults.standard
        defaults.set(dateString, forKey:dateStringKey)
        defaults.set(counterTotal, forKey:counterKey)
        defaults.synchronize()
    }
}
