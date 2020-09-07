//
// Created by 백상휘 on 2020/09/02.
// Copyright (c) 2020 Sanghwi Back. All rights reserved.
//

import Foundation
import UIKit

class MyURLSession: URLSession, URLSessionDataDelegate {
    var qualifiedURL: String?
    var requestMovieDataType: RequestMovieDataType = .dailyBoxOffice
    let decoder = JSONDecoder()

    private lazy var session: URLSession = {
        let conf = URLSessionConfiguration.default
        return URLSession(configuration: conf, delegate: self, delegateQueue: OperationQueue.main)
    }()

    private var willWaitForSignal: Bool = true {
        willSet {
            self.session.configuration.waitsForConnectivity = newValue
        }
    }
    
    func startLoad(requestDataType: RequestMovieDataType, _ completionHandler: @escaping (DailyBoxOfficeResult?) -> Void) {
        guard let qualifiedURL = qualifiedURL, let url = URL(string: qualifiedURL) else { return }
        
        let task = self.session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let mimeType = response.mimeType,
                mimeType == "application/json" else {
                    return
            }
            
            // JSON데이터 호출부. 맨 마지막 completionHandler 를 호출함.
            DispatchQueue.main.async {
                if let data = data,
                    let product = try? self.decoder.decode(DailyBoxOfficeData.self, from: data) {
                    completionHandler(product.boxOfficeResult)
                }
            }
        }
        task.resume()
    }
    
    /**
     Update stored URL's parameter.
     If there is no parameter you asked, it will added.
     */
    @discardableResult
    func updateURLParameter(key: String, value: String) -> Bool {
        guard let url = qualifiedURL, let questionIndex = url.firstIndex(of: "?") else {
            return false
        }
        
        var parameters = Dictionary<String, String>()
        let parameterString = String(url[url.index(after: questionIndex)...])
        
        if parameterString.isEmpty {
            self.qualifiedURL = url + key + "=" + value
            return true
        }
        
        for item in parameterString.split(separator: "&") {
            if let splitIndex = item.firstIndex(of: "=") {
                parameters.updateValue(String(item[item.index(after: splitIndex)...]), forKey: String(item[item.startIndex..<splitIndex]))
            } else {
                return false
            }
        }
        
        if parameters.isEmpty {
            return false
        }
        
        parameters.updateValue(value, forKey: key)
        var resultParameters = parameters.reduce("?"){$0+$1.key+"="+$1.value+"&"}
        resultParameters.removeLast()
        
        self.qualifiedURL = String(self.qualifiedURL![self.qualifiedURL!.startIndex..<questionIndex]) + resultParameters
        
        return true
    }
}
