//
//  Word+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var engTitle: String
    @NSManaged public var isLearning: Bool
    @NSManaged public var rusTitle: String
    @NSManaged public var topic: Topic?

}

extension Word : Identifiable {

}
