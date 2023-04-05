//
//  Model.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 05.04.2023.
//

import Foundation


 public enum HomeModels {

  /// Набор запросов для одного VIP цикла
public  enum FetchCars {

    /// Запрос к Interactor из View Controller
 public   struct Request {
      let userName: String
    }

    /// Запрос к Presentor из Interactor
 public   struct Response {
      let cars: Cars
      
    }

    /// Запрос к View Controller из Presentor
  public  struct ViewModel {
      let cars: Cars
    }
  }
}
