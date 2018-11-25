//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    var homeModules : [Modules] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URLRequest(url: URL(string: "https://www.nbcbayarea.com/apps/news-app/home/modules/?apiVersion=14&os=ios")!)
        ApiService.apiServiceRequest(requestUrl: url, resultStruct: HomeBase.self) { (data, Error) in
            guard let homemodulesData = data as? HomeBase else {
                return
            }
            self.homeModules = homemodulesData.modules ?? self.homeModules
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeModules.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.homeModules[indexPath.row].title
        return cell!
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
