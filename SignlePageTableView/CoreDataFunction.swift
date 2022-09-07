//
//  CoreDataFunction.swift
//  NationalTM
//
//  Created by Hamza on 14/08/2022.
//

import Foundation
import CoreData
import UIKit

class Entities {
    static var Song = "Songs"
    static var Archives = "ArchivedSongs"
}

class Entity_Attributes {
    static var date_received = "date_received"
    static var date_deleted = "date_deleted"
    static var has_been_viewed = "has_been_viewed"
    static var song_cate = "song_cate"
    static var song_id = "song_id"
    static var song_title = "song_title"
    static var date_archived = "date_archived"
}


class CoreData_functions{
    //MARK: CORE DATA
    
    static var SONGSLIST: [Songs] = []
    static var ARCHIVES: [ArchivedSongs] = []
    
    private let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    static func saveSongsData(valuesForKeys: [String:Any]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Entities.Song, in: managedContext)!
        let user = NSManagedObject(entity: entity,insertInto: managedContext)
        for item in valuesForKeys {
            user.setValue(item.value, forKey: item.key)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func saveArchivedSongData(valuesForKeys: [String:Any]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Entities.Archives, in: managedContext)!
        let user = NSManagedObject(entity: entity,insertInto: managedContext)
        for item in valuesForKeys {
            user.setValue(item.value, forKey: item.key)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func deleteSongData(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.entity(forEntityName: Entities.Song, in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = user
        let predicate = NSPredicate(format: "(song_id = %@)", "\(id)")
        request.predicate = predicate
        do {
            managedContext.delete(CoreData_functions.SONGSLIST[id])
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func deleteArchivedSongData(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.entity(forEntityName: Entities.Archives, in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = user
        let predicate = NSPredicate(format: "(song_id = %@)", "\(id)")
        request.predicate = predicate
        do {
            managedContext.delete(CoreData_functions.ARCHIVES[id])
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchSongsList(completion: @escaping(Int) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Songs>(entityName: Entities.Song)
        let movieSort = NSSortDescriptor(key: "date_received", ascending: false)
        fetchRequest.sortDescriptors = [movieSort]
        do {
            CoreData_functions.SONGSLIST = try managedContext.fetch(fetchRequest)
            print(CoreData_functions.SONGSLIST)
            completion(CoreData_functions.SONGSLIST.count)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchArchiveList(completion: @escaping(Int) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArchivedSongs>(entityName: Entities.Archives)
        let movieSort = NSSortDescriptor(key: "date_received", ascending: false)
        fetchRequest.sortDescriptors = [movieSort]
        do {
            CoreData_functions.ARCHIVES = try managedContext.fetch(fetchRequest)
            print(CoreData_functions.ARCHIVES)
            completion(CoreData_functions.ARCHIVES.count)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}
