//
//  InternetService.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 05.04.2023.
//

import UIKit
import Combine

public struct Cars: Codable {
    let news: [Car]
}
public struct Car: Codable {
    let title: String
}


protocol InternetServiceProtocol {
    func dataTaskMethod()
}


public class InternetService {
    
    var presenter: Presenter?
    var observer: AnyCancellable?
    
    public   var cars: Cars? 
    
    public  func dataTaskMethod(handler:
                                @escaping (Cars) -> Void) {
          
          let url = URL(string: "https://webapi.autodoc.ru/api/news/1/15")
          
          let task = URLSession.shared.dataTask(with: url!) {[unowned self] data, response, error in
              guard let httpResponse = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponse.statusCode) else {
                  return
              }
              guard let data = data else {
                  return
              }
              let jsonDecoder = JSONDecoder()
              var cars = try! jsonDecoder.decode(Cars.self, from: data)
              print(cars)
              handler(cars)
          }
          task.resume()
      
    }
    
    
}
