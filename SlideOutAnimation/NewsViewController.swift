//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit
import GoogleMobileAds


class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate {
    
    var bannerView : GADBannerView!
    enum CellType: String {
        case titleCell = "Cell"
        case leadCell = "Headline Centric"
        case photoCentric = "Photo Centric"
    }
    
    func getCellType(indexPath: IndexPath) -> CellType {
        switch self.homeModules[indexPath.row].template{
        case CellType.leadCell.rawValue:
            return .leadCell
        case CellType.photoCentric.rawValue:
            return .photoCentric
        default :
            return .titleCell
        }
    }
 
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var homeModules : [Modules] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        let url = URLRequest(url: URL(string: "https://www.nbcbayarea.com/apps/news-app/home/modules/?apiVersion=14&os=ios")!)
        self.activityIndicator.startAnimating()
        self.tableView.isHidden = true
        ApiService.apiServiceRequest(requestUrl: url, resultStruct: HomeBase.self) { (data, Error) in
            guard let homemodulesData = data as? HomeBase else {
                return
            }
            self.homeModules = homemodulesData.modules ?? self.homeModules
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeModules.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let type: CellType = self.getCellType(indexPath: indexPath)
        switch type.self {
        case .titleCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else{
                return UITableViewCell()
            }
             cell.textLabel?.text = self.homeModules[indexPath.row].title ?? "Test"
            return cell
        case .leadCell:
            guard let cell : NewsLeadCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsLeadCell") as? NewsLeadCellTableViewCell else {
                return UITableViewCell()
            }
            cell.headingLabel.text = self.homeModules[indexPath.row].title
            let contentItems : [Items] = self.homeModules[indexPath.row].items!
            cell.titleLabel.text = contentItems.first!.title
            let imageUrl =  URL(string: contentItems.first?.leadImageURL ?? "")
            let imageData = NSData(contentsOf: imageUrl!)
            cell.leadImage.image = UIImage.init(data: imageData! as Data)
            return cell
            
        case .photoCentric:
            guard let photoCentricTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCentric") as? PhotoCentricTableViewCell, let items : [Items] = homeModules[indexPath.row].items  else {
                return UITableViewCell()
            }
            photoCentricTableViewCell.sectionTitle.text = self.homeModules[indexPath.row].title
            photoCentricTableViewCell.homeContentArray = items
            photoCentricTableViewCell.collectionView.delegate = photoCentricTableViewCell
            photoCentricTableViewCell.collectionView.dataSource = photoCentricTableViewCell
            photoCentricTableViewCell.collectionView.reloadData()
            return photoCentricTableViewCell
        
        }
        
}
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let type: CellType = self.getCellType(indexPath: indexPath)
        switch type.self {
        case .titleCell:
            return 20.0
        case .leadCell:
            return 300.0
        case .photoCentric:
            return 360.0
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    //Banner Ad Delegate methods
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    
    
}
