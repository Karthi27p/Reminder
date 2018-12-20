//
//  TodayViewController.swift
//  StickyNotes
//
//  Created by Karthi on 12/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    var stickyNotes : Array<Any> = []
    let defaults = UserDefaults()
    @IBOutlet var tableView: UITableView!
    
    //Static content for sticky notes
    let stickyNoteasObj = StickyNotesViewController()
        override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        //Static content for sticky notes
        stickyNotes = StickyNotesViewController.stickeyNotesObj.retriveStickyNotes()
        // Enable app groups and uncomment below lines
            //defaults.addSuite(named: "group.com.tringapps.slideAnimation")
            //stickyNotes = defaults.object(forKey: "StickyNotes") as! Array<Any>
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        //Static content for sticky notes
        stickyNotes = StickyNotesViewController.stickeyNotesObj.retriveStickyNotes()
        // Enable app groups and uncomment below lines
        //defaults.addSuite(named: "group.com.tringapps.slideAnimation")
        //stickyNotes = defaults.object(forKey: "StickyNotes") as! Array<Any>
        completionHandler(NCUpdateResult.newData)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stickyNotes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StickyNotes")
        let imageView : UIImageView = cell!.viewWithTag(999) as! UIImageView
        imageView.image = #imageLiteral(resourceName: "Pin")
        let textArea : UITextView = cell!.viewWithTag(1000) as! UITextView
        textArea.text = stickyNotes[indexPath.row] as? String
        return cell!
        
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (CGFloat(Int(UIScreen.main.bounds.height)/stickyNotes.count)-10)
    }
    
    public func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize)
    {
        if(activeDisplayMode == NCWidgetDisplayMode.compact)
        {
            self.preferredContentSize = maxSize
        }
        else
        {
            
            self.preferredContentSize = CGSize(width: maxSize.width,height:1000.0)
        }
    }
}
