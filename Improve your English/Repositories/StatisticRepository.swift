//
//  StatisticRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 25/10/2022.
//

import Foundation

final class StatisticRepository {
    static let shared = StatisticRepository()
    
    private init() { }
    
    func addData(wordsCount: Int) {
        let newData = Statistic(context: CoreDataManager.shared.context)
        newData.wordsCount = Int32(wordsCount)
        newData.date = Date().currentDay
        
        CoreDataManager.shared.save()
    }
    
    func wordsCount(from startDate: Date) -> Int {
        var fetchedData: [Statistic] = []
        let request = Statistic.fetchRequest()
        let predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, Date().currentDay as CVarArg)
        request.predicate = predicate
        
        do {
            fetchedData = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        var wordsCount: Int = 0
        
        fetchedData.forEach { data in
            wordsCount += Int(data.wordsCount)
        }
        
        return wordsCount
    }
    
    func minimumDate() -> Date {
        var fetchedData: [Statistic] = []
        
        do {
            fetchedData = try CoreDataManager.shared.context.fetch(Statistic.fetchRequest())
        } catch {
            print(error)
        }
        
        var minimumDate: Date = Date().currentDay
        
        for data in fetchedData {
            guard let date = data.date, minimumDate > date else {
                continue
            }
            
            minimumDate = date
        }
        
        return minimumDate
    }
}
