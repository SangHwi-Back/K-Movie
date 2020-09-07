//
// Created by 백상휘 on 2020/09/02.
// Copyright (c) 2020 Sanghwi Back. All rights reserved.
//

import Foundation

class Constants {
    static let kosbiRESTUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    static let dailyBoxOfficeURL = "boxoffice/searchDailyBoxOfficeList.json?"
    static let weeklyBoxOfficeURL = "boxoffice/searchWeeklyBoxOfficeList.json?"
    
    
    
    
    static let categories = ["박스오피스", "영화목록", "영화사정보", "영화인목록"]
    static let categoriesSegue = ["박스오피스":"boxOfficeSegue", "영화목록":"movieListSegue", "영화사정보":"companyListSegue", "영화인목록":"peopleListSegue"]
}
