//
//  Word+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 20/10/2022.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var engTitle: String
    @NSManaged public var rusTitle: String
    @NSManaged public var learningWords: NSSet?
    @NSManaged public var topic: Topic

}

// MARK: Generated accessors for toLearningWords
extension Word {

    @objc(addToLearningWordsObject:)
    @NSManaged public func addToToLearningWords(_ value: LearningData)

    @objc(removeToLearningWordsObject:)
    @NSManaged public func removeFromToLearningWords(_ value: LearningData)

    @objc(addToLearningWords:)
    @NSManaged public func addToToLearningWords(_ values: NSSet)

    @objc(removeToLearningWords:)
    @NSManaged public func removeFromToLearningWords(_ values: NSSet)

}

extension Word : Identifiable {

}
