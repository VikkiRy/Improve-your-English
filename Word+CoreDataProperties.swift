//
//  Word+CoreDataProperties.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var title: String?
    @NSManaged public var topic: Topic?

}

extension Word : Identifiable {

}
