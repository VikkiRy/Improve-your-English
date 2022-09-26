//
//  Topic1+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 26/09/2022.
//
//

import Foundation
import CoreData


extension Topic1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic1> {
        return NSFetchRequest<Topic1>(entityName: "Topic1")
    }

    @NSManaged public var title: String?
    @NSManaged public var words: String?
    @NSManaged public var topicToWord: NSSet?

}

// MARK: Generated accessors for topicToWord
extension Topic1 {

    @objc(addTopicToWordObject:)
    @NSManaged public func addToTopicToWord(_ value: Word)

    @objc(removeTopicToWordObject:)
    @NSManaged public func removeFromTopicToWord(_ value: Word)

    @objc(addTopicToWord:)
    @NSManaged public func addToTopicToWord(_ values: NSSet)

    @objc(removeTopicToWord:)
    @NSManaged public func removeFromTopicToWord(_ values: NSSet)

}

extension Topic1 : Identifiable {

}
