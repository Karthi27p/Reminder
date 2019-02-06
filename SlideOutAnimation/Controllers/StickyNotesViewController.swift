//
//  StickyNotesViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 12/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class StickyNotesViewController: UIViewController {
    static let stickeyNotesObj = StickyNotesViewController()
    @IBOutlet var textArea: UITextView!
    
    //var stickyNotesContent = ["Set up call at 7.00 PM and send minutes by 9.00 PM. Discuss about the velocity for this sprint. Discuss about relative sizing", "Buy kiwi from fruit shop. Collect the parcel from counter", "Get meat for the pets", "Pay electricity bill by 20th"]
    var stickyNotesContent = Array<String>()
    
    //MARK: App life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func retriveStickyNotes() -> Array<Any>
    {
        print("Array Count is \(StickyNotesViewController.stickeyNotesObj.stickyNotesContent.count)")
        return StickyNotesViewController.stickeyNotesObj.stickyNotesContent
    }

    //MARK: Button Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pasteButtonPressed(_ sender: Any) {
        //StickyNotesViewController.stickeyNotesObj.stickyNotesContent.append(self.textArea.text)
        self.stickyNotesContent.append(self.textArea.text)
        let userDefaults = UserDefaults.init(suiteName: "group.com.tringapps.pets")
        userDefaults!.setValue(stickyNotesContent, forKey: "StickyNotes")
        userDefaults?.synchronize()
    }
}
