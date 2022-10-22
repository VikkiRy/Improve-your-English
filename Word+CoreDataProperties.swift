//
//  Word+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 22/10/2022.
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
    @NSManaged public var isTrainingCompleted: Bool
    @NSManaged public var learningData: NSSet?
    @NSManaged public var topic: Topic

}

// MARK: Generated accessors for learningData
extension Word {

    @objc(addLearningDataObject:)
    @NSManaged public func addToLearningData(_ value: LearningData)

    @objc(removeLearningDataObject:)
    @NSManaged public func removeFromLearningData(_ value: LearningData)

    @objc(addLearningData:)
    @NSManaged public func addToLearningData(_ values: NSSet)

    @objc(removeLearningData:)
    @NSManaged public func removeFromLearningData(_ values: NSSet)

}

extension Word : Identifiable {

}
