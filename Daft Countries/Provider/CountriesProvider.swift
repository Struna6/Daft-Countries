//
//  CountriesProvider.swift
//  Daft Countries
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import UIKit

class CountriesProvider : CountriesProviding{
    
    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        var countries = [Country]()
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            do{
                guard let data = data else {return}
                countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            }catch{
                completion(.failure(.errorGettingData))
            }
        }
        task.resume()
    }

    private var baseURL = URL(string: "https://restcountries.eu/rest/v2/all")!
}
