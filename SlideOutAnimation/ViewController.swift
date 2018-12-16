//
//  ViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 04/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate{

    var photos : [UIImage] = [#imageLiteral(resourceName: "events"),#imageLiteral(resourceName: "news"),#imageLiteral(resourceName: "map"),#imageLiteral(resourceName: "diary")]
    var diaryItems : [NSManagedObject] = []
    var tagValue : Int = 5
    
    @IBOutlet var collectionView: UICollectionView!
    @IBAction func menuButtonAction(_ sender: Any) {
    performSegue(withIdentifier: "OpenMenu", sender: (Any).self)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
            collectionView.backgroundColor = UIColor.clear
        }
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self as customLayoutDelegate
        }
         tagValue = 5
        self.transitioningDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        navigationController?.delegate = self
    }
    
    //Collection View Implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        tagValue -= 1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell" , for:indexPath)
        let photoImageView = cell.viewWithTag(100) as! UIImageView
        let cornerImage = cell.viewWithTag(indexPath.row+1) as! UIImageView
        let cornerImageName : String = "square\(indexPath.row+1)"
        cornerImage.image = UIImage(named: cornerImageName)
        
        //4321
        
        let centerImage = cell.viewWithTag(tagValue) as! UIImageView
        let centerImageName : String = "square\(centerImage.tag)"
        centerImage.image = UIImage(named: centerImageName)
        
       
            

        
        photoImageView.image = photos[indexPath.row]
        photoImageView.frame.size.height = (cell.frame.size.height)
        photoImageView.frame.size.width = cell.frame.size.width
        cell.backgroundColor = UIColor.white
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    let customNavigationViewController = CustomNavigationController()

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        customNavigationViewController.reverse = false
        return customNavigationViewController as UIViewControllerAnimatedTransitioning
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination
        destinationVC.transitioningDelegate = self
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if(indexPath.row == 0)
        {
            self.performSegue(withIdentifier: "Day", sender: nil)
        }
        if(indexPath.row == 1)
        {
            self.performSegue(withIdentifier: "News", sender: nil)
        }
        if(indexPath.row == 2)
        {
            self.performSegue(withIdentifier: "Map", sender: nil)
        }
        if(indexPath.row == 3)
        {
            if(self.diaryItems.count == 0)
            {
                self.performSegue(withIdentifier: "AddToDiary", sender: nil)
            }
            else
            {
                self.performSegue(withIdentifier: "Diary", sender: nil)
            }
            
        }
    }
    
    }

extension ViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentViewController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissViewController()
    }
}

extension ViewController : customLayoutDelegate {
    // 1
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        /*let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: photo.size, insideRect: boundingRect)
        return rect.size.height*/
         return (UIScreen.main.bounds.size.height/2)-64
    }
    
}

