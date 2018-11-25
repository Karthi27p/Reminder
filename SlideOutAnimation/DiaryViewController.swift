//
//  DiaryViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 02/09/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData

class DiaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    var pageIndex : Int = 0
    var titleArray : Array<Any> = []
    var contentArray : Array<Any> = []
    var imageArray : Array<Any> = []
    var diaryItems : [NSManagedObject] = []
    var contentHeight : CGFloat = 0
    var contentDeleted = false
    @IBOutlet var animatedImageViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet var tableView: UITableView!
    @IBOutlet var animatedImageView: UIImageView!
    @IBOutlet var minimizedImageView: UIImageView!
    @IBOutlet var animatedImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var container: UIView!
    @IBOutlet var containerWidthConstraint: NSLayoutConstraint!
    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    var imageViewWidth = UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self as UINavigationControllerDelegate
         self.animatedImageViewWidthConstraint.constant = self.imageViewWidth
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        fetchDataFromSQLite()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        if(contentDeleted)
        {
            fetchDataFromSQLite()
            contentDeleted = false
        }
        if(pageIndex >= diaryItems.count)
        {
            pageIndex = 0
        }
        if(diaryItems.count >= 1)
        {
        container.isHidden = false
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryImageCell") as! DiaryImageCellTableViewCell
            let event = diaryItems[pageIndex]
            let imageData = event.value(forKey: "image") as? Data
            self.animatedImageView.image = UIImage(data: imageData!)
            self.minimizedImageView.image = UIImage(data: imageData!)
            //self.animatedImageView.image = imageArray[pageIndex] as? UIImage
            //self.minimizedImageView.image = imageArray[pageIndex] as? UIImage
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DiaryContentCell
            //cell.titleLabel.text = titleArray[pageIndex] as? String
            //cell.contentLabel.text = contentArray[pageIndex] as? String
            let event = diaryItems[pageIndex]
            cell.titleLabel.text = event.value(forKey: "title") as? String
            cell.contentLabel.text = event.value(forKey: "Content") as?
             String
            if let content = cell.contentLabel.text {
            contentHeight = calculateHeightForContentText(text: content as NSString)
            }
            return cell
        }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryImageCell") as! DiaryImageCellTableViewCell
            cell.imageView?.image = nil
            container.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideDeleteButton"), object: nil)
            return cell
        }
        
    }
    
 
    let customNavigationViewController = CustomNavigationController()
    let customInteractionViewController = CustomInteractionController()
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y >= 0)
        {
        if((scrollView.contentOffset.y < 180) && (180-scrollView.contentOffset.y > 50))
        {
            self.minimizedImageView.isHidden = true
            self.animatedImageView.isHidden = false
            self.animatedImageViewHeightConstraint.constant = 180-scrollView.contentOffset.y
            self.containerHeightConstraint.constant = 180-scrollView.contentOffset.y
            self.minimizedImageView.isHidden = true
            print(scrollView.contentOffset.y)
            if(scrollView.contentOffset.y < self.imageViewWidth)
            {
                self.animatedImageViewWidthConstraint.constant = self.imageViewWidth * (self.animatedImageViewHeightConstraint.constant/180)
            }
            else
            {
                self.animatedImageViewWidthConstraint.constant = self.imageViewWidth
            }
        }
        else
        {
            self.minimizedImageView.isHidden = false
            self.animatedImageView.isHidden = true
            self.containerWidthConstraint.constant = imageViewWidth
            self.containerHeightConstraint.constant = 50.0
        }
    }
        else
        {
            self.minimizedImageView.isHidden = true
            self.animatedImageView.isHidden = false
            self.containerHeightConstraint.constant = 180
            self.animatedImageViewWidthConstraint.constant = self.imageViewWidth
            self.animatedImageViewHeightConstraint.constant = 180
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 180
        }
        else
        {
            return (contentHeight > tableView.frame.height-180) ? contentHeight : tableView.frame.height-180
        }
    }
    
    func calculateHeightForContentText(text : NSString) -> CGFloat
    {
        let maxLabelSize = CGSize(width: self.tableView.frame.width, height: CGFloat(MAXFLOAT))
        let contentSize = text.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:[NSFontAttributeName: UIFont .systemFont(ofSize: 17.0)], context: nil)
        return contentSize.height+20
    }
    
    func fetchDataFromSQLite()
    {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
        
        do{
            try
                diaryItems = managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("\(error)")
        }
    }
    
//    func getDiaryContents(titleArray : Array<Any>, contentArray : Array<Any>, imageArray : Array<Any>)
//    {
//        self.titleArray = titleArray
//        self.contentArray = contentArray
//        self.imageArray = imageArray
//    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
