
//
//  PageViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 02/09/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    //static let pageViewControllerSharedInstance = PageViewController()
    var titleArray : Array<Any> = []
    var contentArray : Array<Any> = []
    var imageArray : Array<Any> = []
    var diaryItems : [NSManagedObject] = []
    var currentIndex = 0
    var hasDiaryItems = false
    var deleteCount = 1
    var diaryViewControllerObj = DiaryViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.titleArray  = ["Title1", "Title2", "Title3", "title4"]
        //self.contentArray = ["Content1", "Content2", "Content3", "Content4"]
        //self.imageArray = [#imageLiteral(resourceName: "page2"),#imageLiteral(resourceName: "page3"),#imageLiteral(resourceName: "page4"),#imageLiteral(resourceName: "page1")]
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        currentIndex = 0
        self.automaticallyAdjustsScrollViewInsets = false
    self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:(#selector(deleteButtonClicked))), animated: true)
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(disableDeleteButton), name: NSNotification.Name(rawValue: "HideDeleteButton"), object: nil)
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
        
        do{
            try
                diaryItems = managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("\(error)")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        let diaryViewController : DiaryViewController = viewController as! DiaryViewController
        var index = diaryViewController.pageIndex
        if(index == 0 || index == NSNotFound)
        {
            currentIndex = 0
            return nil
        }
        else
             {
                index -= 1
                currentIndex = index+1
        }
        return getViewControllerAtIndex(index: index)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let diaryViewController : DiaryViewController = viewController as! DiaryViewController
        var index = diaryViewController.pageIndex
        if(index == NSNotFound)
        {
            return nil
        }

        if(self.diaryItems.count-deleteCount == index)
       {
        currentIndex = index
        return nil
        }
        else
      {
        index += 1
        currentIndex = index-1
//        if(diaryItems.count <= 2)
//        {
//        index = 0
//        }
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> DiaryViewController
    {
        diaryViewControllerObj = storyboard?.instantiateViewController(withIdentifier: "Diary") as! DiaryViewController
        diaryViewControllerObj.pageIndex = (diaryItems.count-1 == currentIndex) ? 0 : index
       
        NSLog("%d", currentIndex)
        //currentIndex = index
        //diaryViewController.getDiaryContents(titleArray: PageViewController.pageViewControllerSharedInstance.titleArray, contentArray: PageViewController.pageViewControllerSharedInstance.contentArray, imageArray: PageViewController.pageViewControllerSharedInstance.imageArray)
        return diaryViewControllerObj
        
    }
    
    func deleteButtonClicked()
    {
        deleteCount += 1
        diaryViewControllerObj.contentDeleted = true
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
        
        do{
            try
                diaryItems = managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("\(error)")
        }
        //currentIndex = (diaryItems.count != 0 && diaryItems.count-1 != currentIndex) ? currentIndex-1 : currentIndex
        currentIndex = currentIndex < 0 ? 0 : currentIndex
        managedContext.delete(diaryItems[currentIndex])
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("\(error)")
        }
        currentIndex = (diaryItems.count-1 == currentIndex) ? 0 : currentIndex
        if(currentIndex <= diaryItems.count && diaryItems.count != 0)
        {
            if(diaryItems.count > 2)
            {
            self.setViewControllers([getViewControllerAtIndex(index: currentIndex)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            }
            else
            {
            self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            }
        }
        //Check in pageviewcontroller and diaryviewcontroller
        //if(currentIndex == diaryItems.count-1)
        //{
        //    diaryViewControllerObj.pageIndex = currentIndex-1
        //}
        if(currentIndex == 0 || currentIndex+1 == diaryItems.count)
        {
        diaryViewControllerObj.pageIndex = 0
        }
        else
        {
        diaryViewControllerObj.pageIndex = currentIndex
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        deleteCount = 1
        NotificationCenter.default.removeObserver(self)
    }

    func disableDeleteButton()
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}
