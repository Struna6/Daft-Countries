//
//  FakeCountries.swift
//  Daft CountriesTests
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import UIKit
@testable import Daft_Countries

class CountriesProviderSpy: CountriesProviding {

    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        self.capturedCompletion = completion
        numberOfCalls += 1
    }

    private (set) var numberOfCalls = 0
    private (set) var capturedCompletion : ((Result<[Country],NetworkError>) -> Void)?

    func simmulateCompletion(country: [Country]) {
        capturedCompletion?(.success(country))
    }

    func simmulateCompletion(error: NetworkError) {
        capturedCompletion?(.failure(error))
    }
}

