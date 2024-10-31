//
//  Card.swift
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/31.
//

import UIKit

let ACE   : UInt8 = 1
let JACK  : UInt8 = 11
let QUEEN : UInt8 = 12
let KING  : UInt8 = 13

let suitStrings = ["♠︎", "♣︎", "♦︎", "♥︎"]
let rankStrings = [
    "", "A", "2", "3", "4", "5", "6", "7",
    "8", "9", "10", "J", "Q", "K"
]

func ==(left: DrawCard, right: DrawCard) -> Bool {
    return left.suit == right.suit && left.rank == right.rank
}

struct DrawCard : Hashable {
    let suit : DrawSuit
    let rank : UInt8 // 1 .. 13
    
    var description : String {
        return rankStrings[Int(rank)] + suitStrings[Int(suit.rawValue)]
    }
    
    var hashValue: Int {
        return Int(suit.rawValue*13 + rank - 1)
    }
    
    init(suit s : DrawSuit, rank r : UInt8) {
        suit = s;
        rank = r
    }
    
    init(dictionary dict : [String : AnyObject]) { // to retrieve from plist
        suit = DrawSuit(rawValue: (dict["suit"] as! NSNumber).uint8Value)!
        rank = (dict["rank"] as! NSNumber).uint8Value
    }
    
    func toDictionary() -> [String : AnyObject] { // to store in plist
        return [
            "suit" : NSNumber(value: suit.rawValue as UInt8),
            "rank" : NSNumber(value: rank as UInt8)
        ]
    }
    
    func isBlack() -> Bool {
        return suit == DrawSuit.spades || suit == DrawSuit.clubs
    }
    
    func isRed() -> Bool {
        return !isBlack()
    }
    
    func isSameColor(_ other : DrawCard) -> Bool {
        return isBlack() ? other.isBlack() : other.isRed()
    }
    
    static func deck() -> [DrawCard] {
        var d : [DrawCard] = []
        for s in 0 ... 3 {
            for r in 1 ... 13 {
                d.append(DrawCard(suit: DrawSuit(rawValue: UInt8(s))!, rank: UInt8(r)))
            }
        }
        return d
    }
    
}
