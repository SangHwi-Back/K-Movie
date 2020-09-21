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
    private let alert = UIAlertController(title: "APIKeySetting", message: "API 키를 다시 세팅합니다.", preferredStyle: .alert)
    private let completionAlert = UIAlertController(title: "", message: "키 셋팅을 완료하였습니다.", preferredStyle: .alert)
    private var alertKeyTextFieldText: String?
    private var action1 : UIAlertAction!
    private var action2 : UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MainView"
        
        self.alertController()
        let rightSetKeyBarButton = UIBarButtonItem(title: "API Key", style: .plain, target: self, action: #selector(showSetKeyWindow))
        navigationItem.setRightBarButton(rightSetKeyBarButton, animated: false)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    private func alertController() {
        //APIKeySetting Initialize
        self.alert.addTextField { (textField) in
            textField.placeholder = "key"
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (_) in
                self.alertKeyTextFieldText = textField.text
            }
        }
        self.action1 = UIAlertAction(title: "확인", style: .default) {
            (_) in
            if self.alertKeyTextFieldText != nil {
                UserDefaults.standard.setValue(self.alertKeyTextFieldText!, forKey: "APIkey")
                self.present(self.completionAlert, animated: true, completion: nil)
            }
        }
        self.action2 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        self.alert.addAction(action1)
        self.alert.addAction(action2)
        
        //APIKeySetting Initialize
        let completionAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        self.completionAlert.addAction(completionAction)
    }
    
    @objc private func showSetKeyWindow() {
        self.alertKeyTextFieldText = nil
        alert.textFields?.first?.text = nil
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Table View delegate
extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        if let key = cell?.textLabel?.text, let identifier = Constants.categoriesSegue[key] {
            cell?.isSelected = false
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
