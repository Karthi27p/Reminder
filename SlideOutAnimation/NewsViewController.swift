//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
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
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
