//
//  Daft_CountriesTests.swift
//  Daft CountriesTests
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import XCTest
@testable import Daft_Countries

class Daft_CountriesTests: XCTestCase {

    var sut : ViewController!
    var countriesProviderSpy : CountriesProviderSpy!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
        _ = sut.view

        countriesProviderSpy = CountriesProviderSpy()
        sut.countriesProvider = countriesProviderSpy
    }

    override func tearDown() {
        sut = nil
        countriesProviderSpy = nil
        super.tearDown()
    }

    func testTableViewIsVisible() {
        XCTAssertFalse(sut.tableView.isHidden)
    }

    func testTableViewNumOfRowsAtStart(){
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func testNoCallsAtBegining(){
        XCTAssertEqual(countriesProviderSpy.numberOfCalls, 0)
    }

    func testCallsAfterBegining(){
        countriesProviderSpy.simmulateCompletion(country: DummyCountry.country)
        XCTAssertEqual(countriesProviderSpy.numberOfCalls, 0)
    }

    func testTableViewNumOfRowsDummyCountry(){
        sut.countries = DummyCountry.country
        sut.tableView.reloadData()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableViewCorrectNameDisplayed(){
        sut.countries = DummyCountry.country
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, DummyCountry.country[0].name)
    }

    func testCapturedCorrectData(){
        countriesProviderSpy.simmulateCompletion(country: DummyCountry.country)

        countriesProviderSpy.fetchCountries { result in
            switch result{
            case .success(let countries):
                XCTAssertEqual(countries.count, 1)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

    func testCapturedNotCorrectData(){
        countriesProviderSpy.simmulateCompletion(country: DummyCountry.country)

        countriesProviderSpy.fetchCountries { result in
            switch result{
            case .success(let countries):
                XCTAssertNil(countries)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}
