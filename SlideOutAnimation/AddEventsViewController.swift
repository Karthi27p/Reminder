//
//  AddEventsViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 10/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData

class AddEventsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var listOfEvents : [NSManagedObject] = []
    static let addEventsObj = AddEventsViewController()
    @IBOutlet var eventImage: UIImageView!
   
    @IBAction func galleryButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    @IBAction func captureButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    @IBAction func repeatSwitchToggled(_ sender: UISwitch) {
       setRepeat = (sender.isOn) ?  true : false
    }
    static var schedulePressed: Bool = false
    var eventNamesArray = ["List of events"]
    var setRepeat = true
    var pathOfImage : String = ""
    @IBOutlet var datePicker: UIDatePicker!
    @IBAction func scheduleButtonPressed(_ sender: Any) {
      AddEventsViewController.addEventsObj.eventNamesArray.append(eventName.text!)
      let selectedDate = datePicker.date
      self.save(name: eventName.text!)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(at: selectedDate, event: eventName.text!, repeatValue:setRepeat)
        self.dismiss(animated: true, completion:nil)
        AddEventsViewController.schedulePressed = true
        //NotificationCenter.default.post(name: .reload, object: nil)
        //let dayEventsObj = DayEventsViewController()
        //DayEventsViewController.dayEventObj.tableView.reloadData()
        //dayEventsObj.updateUserSelectedImage()
    }
    
   
    
   
    @IBOutlet var remindMeBefore: UITextField!
    @IBOutlet var eventName: UITextField!
        override func viewDidLoad() {
            
        super.viewDidLoad()
        AddEventsViewController.schedulePressed = false
        let calender = NSCalendar.init(calendarIdentifier: .gregorian)
        let components = NSDateComponents()
        let currentDate = Date.init(timeIntervalSinceNow: 0)
        let minDate = calender?.date(byAdding: components as DateComponents, to: currentDate, options: [])
        datePicker.minimumDate = minDate
        self.navigationController?.navigationBar.topItem?.title = "Add Events"
        self .createDirectory()
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddEventsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
            let fileManager = FileManager.default
            let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent("userSelectedImage.png")
            if fileManager.fileExists(atPath: imagePath){
                self.eventImage.image = UIImage(contentsOfFile: imagePath)
            }else{
                print("No Image")
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        eventImage.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("userSelectedImage.png")
        let image = eventImage.image
        print(paths)
        pathOfImage = paths
        let imageData = image!.pngData()
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        NotificationCenter.default.post(name: .updateImage, object: nil)
        dismiss(animated: true, completion: nil)

    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString)
        print(paths)
        if !fileManager.fileExists(atPath: paths as String){
            try! fileManager.createDirectory(atPath: paths as String, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
        print(fileManager.currentDirectoryPath)
        
    }

    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func save(name: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Events", in: managedContext)
        let event = NSManagedObject(entity: entity!, insertInto: managedContext)
        event.setValue(name, forKey: "eventName")
        event.setValue(setRepeat, forKey: "isRepeat")
        event.setValue(datePicker.date, forKey: "dateAndTime")
        do{
            try managedContext.save()
            listOfEvents.append(event)
        }
        catch let error as NSError {
                print("\(error)")
            }
        
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        AddEventsViewController.schedulePressed = true
    }
   
}

extension Notification.Name
{
    //static let reload = Notification.Name("reload")
    static let updateImage = Notification.Name("updateImage")
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
