//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource {
    
    enum CellType: String {
        case titleCell = "Cell"
        case leadCell = "NewsLeadCell"
    }
    
    func getCellType(indexPath: IndexPath) -> CellType {
        switch  indexPath.row%2 {
        //case 0:
         //   return .titleCell
        default:
            return .leadCell
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
    
        let type: CellType = indexPath.row == 1 ? .titleCell : self.getCellType(indexPath: indexPath)
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
        default:
            return UITableViewCell()
        }
        
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
