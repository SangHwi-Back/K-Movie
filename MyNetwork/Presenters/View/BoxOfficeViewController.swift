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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "BoxOffice"
        
        // viewModel, useCases를 지나서 completionHandler를 URLSession fetch하는 소스까지 전달함.
        self.viewModel.loadData(type: .dailyBoxOffice) { (value) in
            self.results = value
            self.boxOfficeCollectionView.reloadData()
        }
        
        print(self.results ?? "aaa")
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
