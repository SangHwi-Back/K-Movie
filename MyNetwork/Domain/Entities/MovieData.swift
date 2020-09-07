//
//  MovieData.swift
//  MyNetwork
//
//  Created by 백상휘 on 2020/09/03.
//  Copyright © 2020 Sanghwi Back. All rights reserved.
//

import Foundation

struct DailyBoxOfficeData: Codable {
    var boxOfficeResult: DailyBoxOfficeResult
}

struct DailyBoxOfficeResult: Codable {
    var boxofficeType: String
    var showRange: String
    var dailyBoxOfficeList: [BoxOfficeList]
}

struct WeeklyBoxOfficeData: Codable {
    var boxOfficeResult: WeeklyBoxOfficeResult
}

struct WeeklyBoxOfficeResult: Codable {
    var boxofficeType: String
    var showRange: String
    var yearWeekTime: String
    var weeklyBoxOfficeList: [BoxOfficeList]
}

struct BoxOfficeList: Codable {
    var rnum: String
    var rank: String
    var rankInten: String
    var rankOldAndNew: String
    var movieCd: String
    var movieNm: String
    var openDt: String
    var salesAmt: String
    var salesShare: String
    var salesInten: String
    var salesChange: String
    var salesAcc: String
    var audiCnt: String
    var audiInten: String
    var audiChange: String
    var audiAcc: String
    var scrnCnt: String
    var showCnt: String
}


//private var _directors: [[String:String]] = [["peopleNm":""]]
//var directors: [[String:String]] {
//    get {
//        return self._directors
//    }
//    set {
//        self._directors = newValue.filter({ $0.keys.filter({$0 == "peopleNm"}).count > 0 && $0.count == 1 })
//    }
//}
