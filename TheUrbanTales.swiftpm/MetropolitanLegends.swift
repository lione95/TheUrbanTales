//
//  MetropolitanLegends.swift
//  LegendStory
//
//  Created by Mattia Golino on 03/04/23.
//

import Foundation

import SwiftUI
import CoreData

@objc(MetropolitanLegends)
class MetropolitanLegends: NSManagedObject, Identifiable{
    
    @NSManaged var legendIndex: UUID
    @NSManaged var legendName: String?
    @NSManaged var legendLocation: String?
    @NSManaged var legenDescription: String?
    @NSManaged var legendTag: String?
    @NSManaged var legendIsRead: Bool
    @NSManaged var legendImage: String
    
}
