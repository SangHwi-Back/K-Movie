//
//  MainViewController.swift
//  MyNetwork
//
//  Created by 백상휘 on 2020/09/02.
//  Copyright © 2020 Sanghwi Back. All rights reserved.
//

import Foundation
import UIKit

enum RequestMovieDataType {
    case dailyBoxOffice; case weeklyBoxOffice
    case movieList; case movieInfo
    case movieCompanyList; case movieCompanyInfo
    case movieContributorList; case movieContributorInfo
}

class MainViewController: UIViewController {

    @IBOutlet var mainTableView: UITableView!
    private(set) var categoryList: [String] = Constants.categories
    private var viewModel = BoxOfficeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MainView"
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

//MARK: - Table View delegate
extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        if let key = cell?.textLabel?.text, let identifier = Constants.categoriesSegue[key] {
            performSegue(withIdentifier: identifier, sender: self)
        } else {
            fatalError("MainViewController Clicked Segue Error")
        }
    }
}

//MARK: - Table View data source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }
}
