//
//  DetailViewModel.swift
//  MyNetwork
//
//  Created by 백상휘 on 2020/09/02.
//  Copyright © 2020 Sanghwi Back. All rights reserved.
//

import Foundation
import UIKit

class BoxOfficeViewModel {
    
    private let useCases = BoxOfficeUseCases()
    var results: DailyBoxOfficeResult?
    
    func loadData(type: RequestMovieDataType, _ completionHandler: @escaping (DailyBoxOfficeResult?) -> Void, errorHandler: @escaping (ErrorInBoxOfficeUseCases) -> Void) {
        /*
         loadData에서 closure를 인자로 받아
         loadData 구현부에서 request가 완료되면 closure에 result를 반환해주도록 하면 될듯
         */
        self.useCases.loadData(type: .dailyBoxOffice, completionHandler, errorHandler: errorHandler)
    }
}
