//
//  ViewController.swift
//  Counter
//
//  Created by jefferson on 9/12/16.
//  Copyright © 2016 tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - ivars -
    var cb:CounterBrain!
    var backgroundImage: UIImage?
    
    
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveDefaultsData),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil)
    }
    
    /**
     * When the view is deinitialized, remove the observer to
     * free up memory
     */
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    @IBAction func share(_ sender: Any) {
        let image = self.view.takeSnapshot()
        let textToShare = "I just used Counter! I'm great!\n\(dateLabel.text!)\n My total is \(totalLabel.text!)!\n"
        let igmWebsite = NSURL(string: "http://igm.rit.edu/")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, igmWebsite!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: { imageP in})
    }
    
    // MARK: - UIImagePickerController Delegate Methods -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("finished picking")
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    /**
     * Save the current state in MyAppData
     */
    func saveDefaultsData(){
        MyAppData.shared.saveDefaultsData()
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

