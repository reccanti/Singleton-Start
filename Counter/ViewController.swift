//
//  ViewController.swift
//  Counter
//
//  Created by jefferson on 9/12/16.
//  Copyright © 2016 tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - ivars -
    var cb:CounterBrain!
    
    
    // an "Immediately Invoked Closure Expression"  - IICE - "Icky"
    var formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    // MARK: - Outlets -
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var launchLabel: UILabel!
    
    // MARK: - ViewController lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        cb = CounterBrain(total: MyAppData.shared.counterTotal)
        totalLabel.text = String(cb.total)
        dateLabel.text = MyAppData.shared.dateString
        displayLaunchTotal()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions -
    @IBAction func clearTapped(_ sender: AnyObject) {
        cb.clear()
        displayTotal()
    }
    @IBAction func plusTapped(_ sender: AnyObject) {
        cb.increment()
        displayTotal()
    }

    @IBAction func minusTapped(_ sender: AnyObject) {
        cb.decrement()
        displayTotal()
    }
    
    // MARK: - Helpers -
    private func displayTotal(){
        MyAppData.shared.counterTotal = cb.total
        totalLabel.text = String(cb.total)
        displayDate()
    }
    
    private func displayDate(){
        let date = Date()
        let dateString = formatter.string(from: date)
        dateLabel.text = "Last used: \(dateString)"
        MyAppData.shared.dateString = dateLabel.text!
    }
    
    private func displayLaunchTotal() {
        MyAppData.shared.launchTotal += 1
        let launchString = String(MyAppData.shared.launchTotal)
        launchLabel.text = "Launched: \(launchString)"
    }

}

