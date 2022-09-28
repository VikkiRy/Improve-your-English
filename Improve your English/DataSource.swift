//
//  DataSource.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/09/2022.
//

import Foundation
import CoreData

class TopicsContext {
    var context: NSManagedObjectContext
    
    init(context: () -> NSManagedObjectContext) {
        self.context = context()
        defaultTopics()
    }
    
    func defaultTopics() {
        let hobbys = [
            "fishing",
            "hunting",
            "blogging",
            "billiards",
            "darts",
            "hiking",
            "body art",
            "gardening",
            "singing",
            "golf"
        ]
        
        let foods = [
            "sandwich",
            "cake",
            "cheese",
            "sausages",
            "salad",
            "soup",
            "potato",
            "tomato",
            "butter",
            "ice-cream"
        ]
        
        let sports = [
            "swimming",
            "cycling",
            "tennis",
            "boxing",
            "gymnastics",
            "golf",
            "basketball",
            "football",
            "volleyball",
            "baseball"
        ]
        
        let topics = [
            "Hobbys": hobbys,
            "Foods": foods,
            "Sports": sports
        ]
        
        topics.forEach { topic in
            let newTopic = Topic(context: context)
            newTopic.title = topic.key;
            let topicWords = topic.value;
            topicWords.forEach({ word in
                let newWord = Word(context: context)
                newWord.title = word
                newWord.topic = newTopic
            })
        }

        do {
            try self.context.save()
            let con = try context.fetch(Topic.fetchRequest())
            con.forEach { topic in
                print(topic.words)
            }
        } catch {
            print(error)
        }
    }
}





/*
let hobbysDescr = [
    "fishing": "the activity of catching fish, either for food or as a sport",
    "hunting": "the activity of hunting wild animals or game",
    "blogging": "add new material to or regularly update a blog",
    "billiards": "a game for two people, played on a billiard table, in which three balls are struck with cues into pockets round the edge of the tabl, with points scored by cannons, pocketing an object ball, or cannoning the cue ball into a pocket",
    "darts": "an indoor game in which small pointed missiles with feather or plastic flights are thrown at a circular target marked with numbers in order to score points",
    "hiking": "the activity of going for long walks, especially across country",
    "body art": "the practice of decorating the body by means of tattooing, piercing, etc.",
    "gardening": "the activity of tending and cultivating a garden, especially as a pastime",
    "singing": "the activity of performing songs or tunes by making musical sounds with the voice",
    "golf": "a game played on a large open-air course, in which a small hard ball is struck with a club into a series of small holes in the ground, the object being to use the fewest possible strokes to complete the course"
]

let foodsDescr = [
    "sandwich": "an item of food consisting of two pieces of bread with a filling between them, eaten as a light meal",
    "cake": "an item of soft sweet food made from a mixture of flour, fat, eggs, sugar, and other ingredients, baked and sometimes iced or decorated",
    "cheese": "a food made from the pressed curds of milk, firm and elastic or soft and semi-liquid in texture",
    "sausages": " an item of food in the form of a cylindrical length of minced pork or other meat encased in a skin, typically sold raw to be grilled or fried before eating",
    "salad": "a cold dish of various mixtures of raw or cooked vegetables, usually seasoned with oil, vinegar, or other dressing and sometimes accompanied by meat, fish, or other ingredients",
    "soup": " a liquid dish, typically savoury and made by boiling meat, fish, or vegetables etc. in stock or water",
    "potato": "the plant of the nightshade family which produces potatoes on underground runners",
    "tomato": "a glossy red, or occasionally yellow, pulpy edible fruit that is eaten as a vegetable or in salad",
    "butter": "a pale yellow edible fatty substance made by churning cream and used as a spread or in cooking",
    "ice-cream": "a soft, sweet frozen food made with milk and cream and typically flavoured with vanilla, fruit, or other ingredients"
]

let sportsDescr = [
    "swimming": "the sport or activity of propelling oneself through water using the limbs",
    "cycling": "the sport or activity of riding a bicycle",
    "tennis": "a game in which two or four players strike a ball with rackets over a net stretched across a court",
    "boxing": "the sport or practice of fighting with the fists, especially with padded gloves in a roped square ring according to prescribed rules (the Queensberry Rules)",
    "gymnastics": "exercises developing or displaying physical agility and coordination",
    "golf": "a game played on a large open-air course, in which a small hard ball is struck with a club into a series of small holes in the ground, the object being to use the fewest possible strokes to complete the course",
    "basketball": "a game played between two teams of five players in which goals are scored by throwing a ball through a netted hoop fixed at each end of the court",
    "football": "any of various forms of team game involving kicking (and in some cases also handling) a ball, in particular (in the UK) soccer or (in the US) American football",
    "volleyball": "a game for two teams, usually of six players, in which a large ball is hit by hand over a high net, the aim being to score points by making the ball reach the ground on the opponent's side of the court",
    "baseball": "a ball game played between two teams of nine on a diamond-shaped circuit of four bases. It is played chiefly as a warm-weather sport in the US and Canada"
]
*/
