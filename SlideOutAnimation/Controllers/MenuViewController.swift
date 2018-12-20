//
//  MenuViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 04/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let menuItems = ["Scheduled Events", "Add Events", "App Icons", "Add To Diary", "Email Reminders"]
    enum RowType: Int {
        case scheduledEvents = 0
        case addEvents
        case appIcons
        //case stickyNotes
        case addToDiary
        case email
    }
    @IBOutlet var tableView: UITableView!
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: App life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    //MARK: Table view delegate methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuItems.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        cell?.textLabel?.text = menuItems[indexPath.row]
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        switch indexPath.row {
        case RowType.scheduledEvents.rawValue:
            let kNavigationBarY = 20.0;
            let dayEventVC = storyBoard.instantiateViewController(withIdentifier: "ScheduledEvents") as! DayEventsViewController
            self.navigationController?.present(dayEventVC, animated: true)
            let navBar : UINavigationBar = UINavigationBar.init(frame: CGRect(x: 0.0, y:kNavigationBarY , width: (Double(UIScreen.main.bounds.size.width)), height: 64.0))
            let navItem = UINavigationItem(title: "Events")
            let leftBarItem = UIBarButtonItem(title: "X", style: UIBarButtonItem.Style.done, target: self, action: #selector(closeButtonPresed))
            leftBarItem.tintColor = UIColor.black
            navItem.leftBarButtonItem = leftBarItem
            navBar.setItems([navItem], animated: true)
            dayEventVC.view.addSubview(navBar)
            dayEventVC.watchAndReadTopConstraint.constant = navBar.frame.height-CGFloat(kNavigationBarY)
            dayEventVC.tableViewTopConstraint.constant = dayEventVC.watchAndReadTopConstraint.constant
            break
        case RowType.addEvents.rawValue:
            let addEventVC = storyBoard.instantiateViewController(withIdentifier: "AddEvents")
            self.navigationController?.present(addEventVC, animated: true)
            break
       
        case RowType.appIcons.rawValue:
            let editEventVC = storyBoard.instantiateViewController(withIdentifier: "AppIcons")
            self.navigationController?.present(editEventVC, animated: true)
            break
       
            // Commented sticky notes UI Due to app groups capability. Still widget will be displayed with static data
            /*case RowType.stickyNotes.rawValue:
            let stickyNotesVC = storyBoard.instantiateViewController(withIdentifier: "StickyNotes")
            self.navigationController?.present(stickyNotesVC, animated: true)
            break*/

        case RowType.addToDiary.rawValue:
            let addToDiaryVC = storyBoard.instantiateViewController(withIdentifier: "AddToDiary")
            self.navigationController?.present(addToDiaryVC, animated: true)
            break
       
        case RowType.email.rawValue:
            let emailVC = storyBoard.instantiateViewController(withIdentifier: "Email")
            self.navigationController?.present(emailVC, animated: true)
            break
            
        default:
            break
        }
    }
    
    //MARK: Close button action
    @objc func closeButtonPresed()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}




