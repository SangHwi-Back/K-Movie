//
//  BoxOfficeUseCases.swift
//  MyNetwork
//
//  Created by 백상휘 on 2020/09/02.
//  Copyright © 2020 Sanghwi Back. All rights reserved.
//

import Foundation
import UIKit

class BoxOfficeUseCases {
    
    var results: DailyBoxOfficeResult?
    
    var myURLSession: MyURLSession?
    var data: Data?
    private let url: String = Constants.kosbiRESTUrl +  Constants.dailyBoxOfficeURL
    let key: String? = UserDefaults.standard.value(forKey: "APIkey") as? String
    
    init() {
        myURLSession = (UIApplication.shared.delegate as? AppDelegate)?.myURLSession
    }
    
    // loadData. url 구성 후 URLSession 클래스의 startLoad함수 실행.
    func loadData(type: RequestMovieDataType, _ completionHandler: @escaping (DailyBoxOfficeResult?) -> Void) {
        myURLSession?.qualifiedURL = url
        myURLSession?.updateURLParameter(key: "key", value: "0e559fe678175166222903f2123ec644")
        myURLSession?.updateURLParameter(key: "targetDt", value: "20200903")
        self.myURLSession?.startLoad(requestDataType: .dailyBoxOffice, completionHandler)
    }
}
