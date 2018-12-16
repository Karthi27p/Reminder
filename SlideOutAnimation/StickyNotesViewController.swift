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
    var stickyNotesContent = ["Test"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

 
    @IBAction func pasteButtonPressed(_ sender: Any) {
        //StickyNotesViewController.stickeyNotesObj.stickyNotesContent.append(self.textArea.text)
        self.stickyNotesContent.append(self.textArea.text)
        let defaults = UserDefaults()
        defaults.addSuite(named: "group.com.tringapps.slideAnimation")
        defaults.set(stickyNotesContent, forKey: "StickyNotes")
        defaults.synchronize()
       
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
