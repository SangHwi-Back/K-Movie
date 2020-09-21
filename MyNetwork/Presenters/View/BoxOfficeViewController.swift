//
//  DetailViewController.swift
//  MyNetwork
//
//  Created by 백상휘 on 2020/09/02.
//  Copyright © 2020 Sanghwi Back. All rights reserved.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    private let viewModel = BoxOfficeViewModel()
    @IBOutlet var boxOfficeCollectionView: UICollectionView!
    var results: DailyBoxOfficeResult?
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BoxOffice"
        
        // viewModel, useCases를 지나서 completionHandler를 URLSession fetch하는 소스까지 전달함.
        // DispatchQueue.main을 이용하여 Serial Queue에 해당 작업을 넣어야 함. errorHandler가 바로 실행되어야 하기 때문.
        DispatchQueue.main.async {
            self.viewModel.loadData(type: .dailyBoxOffice) { (value) in
                self.results = value
                self.boxOfficeCollectionView.reloadData()
            } errorHandler: { (error) in
                
                let action = UIAlertAction(title: "확인", style: .cancel) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                if error == .apiKeyError {
                    self.alert.title = "API Key 에러"
                    self.alert.message = "API Key가 없습니다. 우측 상단의 버튼을 이용하여 세팅해주세요."
                } else if error == .dataDecodingError {
                    self.alert.title = "Data Decoding 에러"
                    self.alert.message = "API Key를 다시 한번 확인해주세요."
                }
                
                self.alert.addAction(action)
                self.present(self.alert, animated: true, completion: nil)
            }
        }
        
        let nib = UINib(nibName: "DailyViewCustomCell", bundle: nil)
        self.boxOfficeCollectionView.dataSource = self
        self.boxOfficeCollectionView.delegate = self
        self.boxOfficeCollectionView.register(nib, forCellWithReuseIdentifier: "boxOfficeViewCell")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.boxOfficeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = results?.dailyBoxOfficeList.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boxOfficeViewCell", for: indexPath) as? DetailViewCustomCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "boxOfficeViewCell", for: indexPath)
        }
        
        if results != nil {
            let dailyBoxOfficeList = results!.dailyBoxOfficeList[indexPath.row]
            cell.customCellMovieNm.text = dailyBoxOfficeList.movieNm
        } else {
            cell.customCellMovieNm.text = "에러 발생!!!"
        }
        
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: collectionView.frame.width / 2 - 40,
                          height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width - 20,
                          height: collectionView.frame.height / 4)
        }
    }
}
