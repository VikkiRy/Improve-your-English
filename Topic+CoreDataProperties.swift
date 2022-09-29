//
//  Topic+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var title: String?
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension Topic {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: Word)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: Word)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}

extension Topic : Identifiable {

}
