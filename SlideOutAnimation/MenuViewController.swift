//
//  MenuViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 04/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let menuItems = ["Scheduled Events", "Add Events", "App Icons", "Sticky Notes", "Add To Diary"]
    @IBOutlet var tableView: UITableView!
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
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
        if(indexPath.row == 0)
        {
            var kNavigationBarY = 0.0;
            if #available(iOS 11.0 , *)
            {
                kNavigationBarY = 20.0;
            }
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
            
            

        }
        if(indexPath.row == 1)
        {
         let addEventVC = storyBoard.instantiateViewController(withIdentifier: "AddEvents")
         self.navigationController?.present(addEventVC, animated: true)
        }
        if(indexPath.row == 2)
        {
            let editEventVC = storyBoard.instantiateViewController(withIdentifier: "EditEvents")
            self.navigationController?.present(editEventVC, animated: true)
        }
        if(indexPath.row == 3)
        {
            let stickyNotesVC = storyBoard.instantiateViewController(withIdentifier: "StickyNotes")
            self.navigationController?.present(stickyNotesVC, animated: true)
        }
        if(indexPath.row == 4)
        {
            let addToDiaryVC = storyBoard.instantiateViewController(withIdentifier: "AddToDiary")
            self.navigationController?.present(addToDiaryVC, animated: true)
        }
    }
    
    
    @objc func closeButtonPresed()
    {
        self.dismiss(animated: true, completion: nil)
    }

}




