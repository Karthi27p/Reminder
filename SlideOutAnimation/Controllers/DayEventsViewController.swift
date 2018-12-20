//
//  DayEventsViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 08/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class DayEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate, GADBannerViewDelegate {
    var listOfEvents : [NSManagedObject] = []
    static let dayEventObj = DayEventsViewController()
    let bannerAdService = BannerAdService()
    let kEvents = "Events"
    @IBOutlet var tableView: UITableView!
    @IBAction func plusButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "Present", sender: (Any).self)
    }
    @IBOutlet var firstEventLabel: UILabel!
    @IBOutlet weak var watchAndReadTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var animatedImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var animatedImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var watchAndReadHeightConstraint: NSLayoutConstraint!
    @IBOutlet var animatedImageView: UIImageView!
    @IBOutlet var minimizedImageView: UIImageView!
    @IBOutlet var animatedImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var animatedImageViewHeightConstraint: NSLayoutConstraint!
    enum cellType: String {
        case LeadCell = "LeadCell"
        case OrdinaryCell = "OrdinaryCell"
    }
    let kWidthImageFull = UIScreen.main.bounds.width
    
    //MARK: App life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self as UINavigationControllerDelegate
        self.updateUserSelectedImage()
        bannerAdService.setBannerAdView(sender: self)
        bannerAdService.addBannerViewToView(senderView: self.view, sender: self)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLeadImage), name: .updateImage, object: nil)
        self.minimizedImageView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        self.animatedImageViewWidthConstraint.constant = kWidthImageFull
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: kEvents)
        
        do{
            try
                listOfEvents = managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table view delegate
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listOfEvents.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(self.getCellType(indexPath: indexPath as NSIndexPath) == .LeadCell)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeadCell") as! LeadCellTableViewCell
            cell.firstEventLabel.text = AddEventsViewController.addEventsObj.eventNamesArray[indexPath.row]
            
            return cell
        }
            
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if(listOfEvents.count > 0)
            {
                let event = listOfEvents[indexPath.row-1]
                cell?.textLabel?.text = event.value(forKey: "eventName") as? String
            }
            return cell!
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete)
        {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appdelegate?.persistentContainer.viewContext
            if(listOfEvents.count > 0)
            {
                managedContext?.delete(listOfEvents[indexPath.row-1])
                if (managedContext?.hasChanges)! {
                    do {
                        try managedContext?.save()
                    } catch {
                        
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: kEvents)
            
            do{
                try
                    listOfEvents = (managedContext?.fetch(fetchRequest))!
            }
            catch let error as NSError{
                print("\(error)")
            }
            self.tableView.reloadData()
            
        }
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row == 0)
        {
            return 180
        }
        else
        {
            return 80
        }
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y >= 0)
        {
            if((scrollView.contentOffset.y < 180.0) && (180.0-scrollView.contentOffset.y > 50.0))
            {
                self.animatedImageView.isHidden = false
                self.minimizedImageView.isHidden = true
                self.animatedImageViewTopConstraint.constant = 0
                self.animatedImageViewLeadingConstraint.constant = 0
                self.animatedImageViewHeightConstraint.constant = 180.0-scrollView.contentOffset.y
                self.watchAndReadHeightConstraint.constant = 180.0-scrollView.contentOffset.y
                if(scrollView.contentOffset.y<kWidthImageFull)
                {
                    self.animatedImageViewWidthConstraint.constant = kWidthImageFull * (self.animatedImageViewHeightConstraint.constant/180.0)
                }
                else
                {
                    self.animatedImageViewWidthConstraint.constant = kWidthImageFull
                }
            }
            else
            {
                self.watchAndReadHeightConstraint.constant = 50
                self.animatedImageView.isHidden = true
                self.minimizedImageView.isHidden = false
            }
        }
        else
        {
            self.animatedImageViewTopConstraint.constant = 0
            self.animatedImageViewLeadingConstraint.constant = 0
            self.animatedImageViewHeightConstraint.constant = 180.0
            self.watchAndReadHeightConstraint.constant = 180.0
            self.animatedImageViewWidthConstraint.constant = kWidthImageFull
            self.animatedImageView.isHidden = false
            self.minimizedImageView.isHidden = true
        }
    }
    
    //View Controller Based Animation
    
    let customAnimationViewController = CustomPresentAnimationController()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Present")
        {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return customAnimationViewController as UIViewControllerAnimatedTransitioning
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimationViewController as UIViewControllerAnimatedTransitioning
    }
    let customNavigationViewController = CustomNavigationController()
    let customInteractionViewController = CustomInteractionController()
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push
        {
            customInteractionViewController.attachToViewController(viewController: toVC)
        }
        if operation == .pop
        {
            self.navigationController?.delegate = nil;
        }
        customNavigationViewController.reverse = (operation == .pop)
        return customNavigationViewController as UIViewControllerAnimatedTransitioning
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionViewController.transitionInProgress ? customInteractionViewController : nil
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func updateUserSelectedImage()
    {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent("userSelectedImage.png")
        print(imagePath)
        if fileManager.fileExists(atPath: imagePath){
            animatedImageView.image = UIImage(contentsOfFile: imagePath)
            minimizedImageView.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("No Image")
        }
    }
    
    @objc func updateLeadImage(_notification: Notification)
    {
        self .updateUserSelectedImage()
    }
    
    //Banner Ad delegate
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Ad received")
        bannerAdService.addBannerViewToView(senderView: self.view, sender: self)
    }
    
    func getCellType(indexPath: NSIndexPath) -> cellType {
        switch indexPath.row {
        case 0:
            return .LeadCell
        default:
            return .OrdinaryCell
        }
    }
    
}
