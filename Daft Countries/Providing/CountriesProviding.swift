//
//  CountriesProviding.swift
//  Daft Countries
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import UIKit

enum NetworkError : Error{
    case errorGettingData
}

protocol CountriesProviding {
    func fetchCountries(completion : @escaping (Result<[Country],NetworkError>) -> Void)
}
