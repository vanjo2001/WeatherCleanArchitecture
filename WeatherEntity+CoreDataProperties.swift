//
//  WeatherEntity+CoreDataProperties.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 23.10.20.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var weatherId: Int64
    @NSManaged public var temperature: Double
    @NSManaged public var weatherDescription: String?

}

extension WeatherEntity : Identifiable {

}
