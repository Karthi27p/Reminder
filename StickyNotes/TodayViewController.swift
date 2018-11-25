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
    //let stickeyNotes : [String] = ["Sometimes users get this error message saying that there is no internet connection message saying that there is no internet connection Sometimes users get this error message saying that there is no internet connection.Sometimes users get this error message saying that there is no internet connection message saying that there is no internet connection", "Note 2", "Note 3", "Note 4", "Note 5"]
    
    //let stickyNoteasObj = StickyNotesViewController()
        override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        //stickyNotes = StickyNotesViewController.stickeyNotesObj.retriveStickyNotes()
            
            defaults.addSuite(named: "group.com.tringapps.slideAnimation")
            stickyNotes = defaults.object(forKey: "StickyNotes") as! Array<Any>
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        //stickyNotes = StickyNotesViewController.stickeyNotesObj.retriveStickyNotes()
        defaults.addSuite(named: "group.com.tringapps.slideAnimation")
        stickyNotes = defaults.object(forKey: "StickyNotes") as! Array<Any>
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
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
        textArea.text = stickyNotes[indexPath.row] as! String
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
