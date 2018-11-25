//
//  AddToDiaryViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 05/09/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData

class AddToDiaryViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var userSelectedImage : UIImage = #imageLiteral(resourceName: "camera")
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet var diaryTextView: UITextView!
    let diaryViewController = DiaryViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
        diaryTextView.delegate = self
        titleTextView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = userSelectedImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToDiaryButtonPressed(_ sender: Any) {
    //PageViewController.pageViewControllerSharedInstance.contentArray.append(diaryTextView.text)
        //PageViewController.pageViewControllerSharedInstance.titleArray.append(titleTextView.text)
        //PageViewController.pageViewControllerSharedInstance.imageArray.append(imageView.image!)
        let imageData = UIImagePNGRepresentation(userSelectedImage)
        self.save(title: titleTextView.text, content: diaryTextView.text, image: imageData!)
        self.titleTextView.text = "Title"
        self.titleTextView.textColor = UIColor.gray
        self.diaryTextView.text = "Enter Your Content"
        self.diaryTextView.textColor = UIColor.gray
        
    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if(textView.text == "Enter Your Content")
        {
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
        if(textView.text == "Title")
        {
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
        
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "")
        {
            if(textView.tag == 101)
            {
            textView.text = "Enter Your Content"
            textView.textColor = UIColor.gray
            }
            else
            {
                textView.text = "Title"
                textView.textColor = UIColor.gray
            }
            
        }
        
        textView.resignFirstResponder()
    }
    
    func dismissKeyBoard()
    {
        self.view.endEditing(true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        self.userSelectedImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func save(title: String, content: String, image: Data)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)
        let event = NSManagedObject(entity: entity!, insertInto: managedContext)
        event.setValue(title, forKey: "title")
        event.setValue(content, forKey: "content")
        event.setValue(image, forKey: "image")
        do{
            try managedContext.save()
        }
        catch let error as NSError {
            print("\(error)")
        }
        
        
        
        
    }
    
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
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
