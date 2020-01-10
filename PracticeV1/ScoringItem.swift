//
//  ScoringItem.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 12/30/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import CoreData

public class ScoringItem:NSManagedObject, Identifiable {
    // booleans
    @NSManaged public var alliance:NSNumber?
    @NSManaged public var endGameFoundation:NSNumber?
    @NSManaged public var endGameParking:NSNumber?
    @NSManaged public var foundation:NSNumber?
    @NSManaged public var parking:NSNumber?
    @NSManaged public var startingZone:NSNumber?
    
    // integers 16 -> 32 -> unique num
    @NSManaged public var capstones:NSNumber?
    @NSManaged public var firstCapstone:NSNumber?
    @NSManaged public var secondCapstone:NSNumber?
    @NSManaged public var skyscraper:NSNumber?
    @NSManaged public var skyStones:NSNumber?
    @NSManaged public var stones:NSNumber?
    @NSManaged public var placedStones:NSNumber?
    @NSManaged public var teleOpStones:NSNumber
    @NSManaged public var teleOpStonesPlaced:NSNumber?
    
    @NSManaged public var autoScore:NSNumber?
    @NSManaged public var teleOpScore:NSNumber?
    @NSManaged public var endgameScore:NSNumber?
    
    @NSManaged public var mechanism:NSNumber?
    
    // strings
    @NSManaged public var event:String?
    @NSManaged public var scorer:String?
    @NSManaged public var teamName:String?
    @NSManaged public var round:String?
    @NSManaged public var teamNum:String?
    
    
    // implementation of booleans
    var isAlliance: Bool {
        get {
            return Bool(truncating: alliance!)
        }
        set {
            alliance = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isEndGameFoundation: Bool {
        get {
            return Bool(truncating: endGameFoundation!)
        }
        set {
            endGameFoundation = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isEndGameParking: Bool {
        get {
            return Bool(truncating: endGameParking!)
        }
        set {
            endGameParking = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isFoundation: Bool {
        get {
            return Bool(truncating: foundation!)
        }
        set {
            foundation = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isParking: Bool {
        get {
            return Bool(truncating: parking!)
        }
        set {
            parking = NSNumber(booleanLiteral: newValue)
        }
    }
    
    var isStartingZone: Bool {
        get {
            return Bool(truncating: startingZone!)
        }
        set {
            startingZone = NSNumber(booleanLiteral: newValue)
        }
    }
}

extension ScoringItem {
    static func getScoreSheets() -> NSFetchRequest<ScoringItem> {
        let request:NSFetchRequest<ScoringItem> = ScoringItem.fetchRequest() as! NSFetchRequest<ScoringItem>
        
        let sortDescriptor = NSSortDescriptor(key: "teamName", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
