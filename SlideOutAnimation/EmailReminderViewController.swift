//
//  EmailReminderViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 16/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class EmailReminderViewController: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    var userSelectedImage : UIImage = #imageLiteral(resourceName: "camera")
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var toTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(AddToDiaryViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddToDiaryViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let calender = NSCalendar.init(calendarIdentifier: .gregorian)
        let components = NSDateComponents()
        let currentDate = Date.init(timeIntervalSinceNow: 0)
        let minDate = calender?.date(byAdding: components as DateComponents, to: currentDate, options: [])
        datePicker.minimumDate = minDate
        toTextView.delegate = self
        subjectTextView.delegate = self
        bodyTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = userSelectedImage
    }
    
    // Text View Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if(textView.text == "To:" || textView.text == "Subject" ||  textView.text == "Body")
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "")
        {
            if(textView.tag == 200)
            {
                textView.text = "To:"
                textView.textColor = UIColor.gray
            }
            else if(textView.tag == 201)
            {
                textView.text = "Subject"
                textView.textColor = UIColor.gray
            } else {
                textView.text = "Body"
                textView.textColor = UIColor.gray
            }
        }
        
        textView.resignFirstResponder()
    }
    
    @objc func dismissKeyBoard()
    {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= UIScreen.main.bounds.height < 586 ? keyboardSize.height - 50 : keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // Image Picker
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        self.userSelectedImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage)!
        dismiss(animated: true, completion: nil)
    }
    
    func configureMailComposer(mailId: [String], subject: String, body: String) -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.setToRecipients(mailId)
        mailComposerVC.setSubject(subject)
        mailComposerVC.addAttachmentData(UIImage(named: "events")!.pngData()!, mimeType: "image/png", fileName: "events.png")
        mailComposerVC.setMessageBody(body, isHTML: false)
        return mailComposerVC
        
    }
    
   
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func captureButtonPresed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    @IBAction func galleryButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        let imageData = userSelectedImage.pngData()
        self.save(to: toTextView.text, subject: subjectTextView.text, body: bodyTextView.text, image: imageData!)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let selectedDate = datePicker.date
        delegate?.emailReminder = true
        delegate?.scheduledBirthdayEmails(at:selectedDate , subject: subjectTextView.text, to:toTextView.text, body: bodyTextView.text)
        self.toTextView.text = "To:"
        self.toTextView.textColor = UIColor.gray
        self.subjectTextView.text = "Subject"
        self.subjectTextView.textColor = UIColor.gray
        self.bodyTextView.text = "Body"
        self.bodyTextView.textColor = UIColor.gray
    }
    
    func save(to: String, subject: String, body:String, image: Data)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Email", in: managedContext)
        let email = NSManagedObject(entity: entity!, insertInto: managedContext)
        email.setValue(to, forKey: "to")
        email.setValue(subject, forKey: "subject")
        email.setValue(body, forKey: "body")
        email.setValue(image, forKey: "image")
        do{
            try managedContext.save()
        }
        catch let error as NSError {
            print("\(error)")
        }
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
