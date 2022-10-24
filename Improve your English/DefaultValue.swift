//
//  WordsForTopic.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 28/09/2022.
//

import Foundation

struct DefaultTopic {
    let title: String
    let words: [DefaultWords]
}

struct DefaultWords {
    let wordENG: String
    let wordRUS: String
}

let fishing = DefaultWords(wordENG: "fishing", wordRUS: "рыбалка")
let hunting = DefaultWords(wordENG: "hunting", wordRUS: "охота")
let blogging = DefaultWords(wordENG: "blogging", wordRUS: "блогинг")
let billiards = DefaultWords(wordENG: "billiards", wordRUS: "бильярд")
let darts = DefaultWords(wordENG: "darts", wordRUS: "дартс")
let hiking = DefaultWords(wordENG: "hiking", wordRUS: "пеший туризм")
let bodyArt = DefaultWords(wordENG: "body art", wordRUS: "боди-арт")
let gardening = DefaultWords(wordENG: "gardening", wordRUS: "садоводство")
let singing = DefaultWords(wordENG: "singing", wordRUS: "пение")
let golfHobby = DefaultWords(wordENG: "golf", wordRUS: "гольф")

let hobbys = DefaultTopic(title: "Hobbys", words: [fishing, hunting, blogging, billiards, darts, hiking, bodyArt, gardening, singing, golfHobby])

let sandwich = DefaultWords(wordENG: "sandwich", wordRUS: "бутерброд")
let cake = DefaultWords(wordENG: "cake", wordRUS: "торт")
let cheese = DefaultWords(wordENG: "cheese", wordRUS: "сыр")
let sausages = DefaultWords(wordENG: "sausages", wordRUS: "сосиски")
let salad = DefaultWords(wordENG: "salad", wordRUS: "салат")
let soup = DefaultWords(wordENG: "soup", wordRUS: "суп")
let potato = DefaultWords(wordENG: "potato", wordRUS: "картошка")
let tomato = DefaultWords(wordENG: "tomato", wordRUS: "помидор")
let butter = DefaultWords(wordENG: "butter", wordRUS: "масло")
let iceCream = DefaultWords(wordENG: "ice-cream", wordRUS: "мороженое")


let foods = DefaultTopic(title: "Foods", words: [sandwich, cake, cheese, sausages, salad, soup, potato, tomato, butter, iceCream])

let swimming = DefaultWords(wordENG: "swimming", wordRUS: "плавание")
let cycling = DefaultWords(wordENG: "cycling", wordRUS: "велоспорт")
let tennis = DefaultWords(wordENG: "tennis", wordRUS: "теннис")
let boxing = DefaultWords(wordENG: "boxing", wordRUS: "бокс")
let gymnastics = DefaultWords(wordENG: "gymnastics", wordRUS: "гимнастика")
let golf = DefaultWords(wordENG: "golf", wordRUS: "гольф")
let basketball = DefaultWords(wordENG: "basketball", wordRUS: "баскетбол")
let football = DefaultWords(wordENG: "football", wordRUS: "футбол")
let volleyball = DefaultWords(wordENG: "volleyball", wordRUS: "волейбол")
let baseball = DefaultWords(wordENG: "baseball", wordRUS: "бейсбол")

let sports = DefaultTopic(title: "Sports", words: [swimming, cycling, tennis, boxing, gymnastics, golf, basketball, football, volleyball, baseball])
