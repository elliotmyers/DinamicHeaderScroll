//
//  Presenter.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 05.04.2023.
//

import UIKit


protocol PresentationLogic {
    func presentCars(_ response: HomeModels.FetchCars.Response)
}


public class Presenter: PresentationLogic {
    
    
    var viewController: HomeDisplayLogic?
    
    
    public   func presentCars(_ response: HomeModels.FetchCars.Response) {
        
            print("RESPONS OK \(response.cars.news.first?.title) ")
        let model = HomeModels.FetchCars.ViewModel(cars: response.cars)
        
        viewController?.displayCars(model)
        
        
    }
}
