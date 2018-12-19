//
//  SlideOutAnimation
//
//  Created by Karthi on 28/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class AppIconsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let imageArray: [UIImage] = [UIImage(named: "diary")!, UIImage(named:"news")!, UIImage(named:"events")!, UIImage(named:"reminder 2")!, UIImage(named:"map")!, UIImage(named:"Reminder")!]
    let imageName = ["diary", "news", "events", "reminder", "map", "DontForget"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppIconCell", for: indexPath) as? AppIconCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2-5), height: (UIScreen.main.bounds.size.height/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeIcon(to: imageName[indexPath.row])
    }
    
    //MARK: Change app icon
    
    func changeIcon(to iconName: String) {
        
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }


    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
