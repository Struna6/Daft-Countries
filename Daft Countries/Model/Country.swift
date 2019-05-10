//
//  Country.swift
//  Countries
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import Foundation

struct Country : Decodable
{
    var name: String
    var capital : String
    var population : Int
    var latlng : [Float]
    var area : Double? = 0
    var timezones : [String]
    var borders : [String]
    var nativeName : String
}

