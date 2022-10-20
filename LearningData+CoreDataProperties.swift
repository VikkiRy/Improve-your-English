//
//  LearningWord+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 20/10/2022.
//
//

import Foundation
import CoreData


extension LearningData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningData> {
        return NSFetchRequest<LearningData>(entityName: "LearningData")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var isLearned: Bool
    @NSManaged public var word: Word

}

extension LearningData : Identifiable {
}
