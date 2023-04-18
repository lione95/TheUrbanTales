//
//  DataController.swift
//  LegendStory
//
//  Created by Mattia Golino on 03/04/23.
//
import CoreData
import SwiftUI

class DataController: ObservableObject{
    
    static let shared = DataController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        
        let metropolitanLegendsEntity = NSEntityDescription()
        metropolitanLegendsEntity.name = "MetropolitanLegends"
        metropolitanLegendsEntity.managedObjectClassName = "MetropolitanLegends"
        
        let legendIndexAttribute = NSAttributeDescription()
        legendIndexAttribute.name = "legendIndex"
        legendIndexAttribute.type = .uuid
        metropolitanLegendsEntity.properties.append(legendIndexAttribute)
        
        let legendNameAttribute = NSAttributeDescription()
        legendNameAttribute.name = "legendName"
        legendNameAttribute.type = .string
        metropolitanLegendsEntity.properties.append(legendNameAttribute)

        let legendLocationAttribute = NSAttributeDescription()
        legendLocationAttribute.name = "legendLocation"
        legendLocationAttribute.type = .string
        metropolitanLegendsEntity.properties.append(legendLocationAttribute)

        let legenDescriptionAttribute = NSAttributeDescription()
        legenDescriptionAttribute.name = "legenDescription"
        legenDescriptionAttribute.type = .string
        metropolitanLegendsEntity.properties.append(legenDescriptionAttribute)

        let legendTagAttribute = NSAttributeDescription()
        legendTagAttribute.name = "legendTag"
        legendTagAttribute.type = .string
        metropolitanLegendsEntity.properties.append(legendTagAttribute)
        
        let legendIsReadAttribute = NSAttributeDescription()
        legendIsReadAttribute.name = "legendIsRead"
        legendIsReadAttribute.type = .boolean
        metropolitanLegendsEntity.properties.append(legendIsReadAttribute)
        
        let legendImageAttribute = NSAttributeDescription()
        legendImageAttribute.name = "legendImage"
        legendImageAttribute.type = .string
        metropolitanLegendsEntity.properties.append(legendImageAttribute)

        let model = NSManagedObjectModel()
        model.entities = [metropolitanLegendsEntity]

        let container = NSPersistentContainer(name: "Model", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("failed with: \(error.localizedDescription)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        container.viewContext.automaticallyMergesChangesFromParent = true
        self.container = container
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Error saving data")
        }
        
    }
    
    func addLegend(aName: String, aLocation: String, aLegenDescription: String, aTag: String, aImage: String, aContext: NSManagedObjectContext) {
        let legend = MetropolitanLegends(context: aContext)
        legend.legendIndex = UUID()
        legend.legendName = aName
        legend.legendLocation = aLocation
        legend.legenDescription = aLegenDescription
        legend.legendTag = aTag
        legend.legendIsRead = false
        legend.legendImage = aImage
        save(context: aContext)
    }
    
    func isReadLegend(aLegend: MetropolitanLegends, aContext: NSManagedObjectContext){
        aLegend.legendIsRead = true
        save(context: aContext)
    }
    
    func getLegends(aContext: NSManagedObjectContext) -> [MetropolitanLegends]{
        var aLegends: [MetropolitanLegends] = []
        let request = NSFetchRequest<MetropolitanLegends>(entityName: "MetropolitanLegends")
        do{
            aLegends = try aContext.fetch(request)
        }catch let error{
            print("Error fetching \(error.localizedDescription)")
        }
        return aLegends
    }
    
}
