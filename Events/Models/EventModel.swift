//
//  EventModel.swift
//  Events
//
//  Created by Tomas Moran on 31/08/2019.
//  Copyright © 2019 Tomas Moran. All rights reserved.
//

import Foundation

class EventModel {
    
    var eventName: String?
    var eventDate: TimeInterval?
    var description: String?
    var initialHour: String?
    var endHour: String?
    
    var location: String?
    var participants: String?
    var typeofEvent: typeOfEvent?
    
    init(eventwith name: String, description: String, date: Date, initialHour: String, endHour: String, location: String, participants: String, typeofEvent: typeOfEvent) {
        self.eventName = name
        self.description = description
        
        self.initialHour = initialHour
        self.endHour = endHour
        
        self.eventDate = date.timeIntervalSinceReferenceDate
        
        self.location = location
        self.participants = participants
        self.typeofEvent = typeofEvent
    }
}

