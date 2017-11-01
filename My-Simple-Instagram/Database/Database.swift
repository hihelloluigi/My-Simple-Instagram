//
//  Database.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the common interface that should be used to read and write data from the local database.
 */
public class Database {
    // MARK: - Constants
    private static let schemaVersion: UInt64 = 7
    
    // MARK: - Singleton
    /**
     The singleton instance of Database.
     */
    public static let shared = Database()
    
    // MARK: - Properties
    fileprivate var realm: Realm?
    
    // MARK: - Constructors
    init() {
        let config = Realm.Configuration(schemaVersion: Database.schemaVersion, migrationBlock: { (migration, oldVersion) in
            switch oldVersion {
            default:
                break
            }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
        } catch let error {
            NSLog("Realm error")
            NSLog("  error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Methods
    /**
     Returns all entities of the specified type which were stored in the local database.
     
     - parameter entityType: the type of entities which should be returned
     - parameter predicate:  the filtering that should be applied to the fetched results
     
     - returns:
     - a Realm cursor of entities of the specified type
     - `nil` otherwise, for example if the local instance of Realm is `nil`
     */
    public func query<T: Object>(entitiesOfType entityType: T.Type, where predicate: NSPredicate? = nil) -> Results<T>? {
        guard let r = realm else {
            return nil
        }
        
        if let p = predicate {
            return r.objects(entityType).filter(p)
        } else {
            return r.objects(entityType)
        }
    }
    /**
     Returns all entities of the specified type which were stored in the local database.
     
     - parameter entityType: the type of entities which should be returned
     - parameter predicate:  the filtering that should be applied to the fetched results
     - parameter skipInvalidated: if `true`, the result array will be filtered by object.isInvalidated - only non-invalidated objects will be returned
     
     - returns:
     - an array of entities of the specified type
     - `nil` otherwise, for example if the local instance of Realm is `nil`
     */
    public func all<T: Object>(entitiesOfType entityType: T.Type, where predicate: NSPredicate? = nil, skipInvalidated: Bool = false) -> [T]? {
        guard let objects = query(entitiesOfType: entityType, where: predicate) else {
            return nil
        }
        
        return Array(objects).filter { object -> Bool in
            return !object.isInvalidated
        }
    }
    /**
     Removes all entities of type T from the local database.
     
     - parameter entityType: the type of the entities that should be removed
     - parameter predicate:  the filtering that should be applied to the deleted results
     
     - returns:
     - `true` if the operation succeedes
     - `false` otherwise, for example if the local instance of Realm is `nil`
     */
    public func delete<T: Object>(entitiesOfType entityType: T.Type, where predicate: NSPredicate? = nil) -> Bool {
        guard let r = realm, let objects = query(entitiesOfType: entityType, where: predicate) else {
            return false
        }
        
        r.beginWrite()
        r.delete(objects)
        
        do {
            try r.commitWrite()
        } catch let error {
            NSLog("Realm error")
            NSLog("  error: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    /**
     Adds an entity to the local database.
     
     - parameter entity: the type of the entity that should be added to the local database
     - parameter update: if an already existing id is passed it will be updated
     - parameter skipKeys: array of keys that will be skipped on update (basically locally stored or upgraded data not synched)
     - returns:
     - `true` if the operation succeedes
     - `false` otherwise, for example if the local instance of Realm is `nil`
     */
    public func add<T: Object>(entity: T, update: Bool = false, skipKeys: [String] = []) -> Bool {
        guard let r = realm else {
            return false
        }
        
        if let primaryKey = T.primaryKey(), let key = entity[primaryKey] {
            let current = r.object(ofType: T.self, forPrimaryKey: key)
            for ignore in skipKeys {
                if let current = current?[ignore] {
                    entity[ignore] = current
                }
            }
        }
        
        r.beginWrite()
        r.add(entity, update: update)
        
        do {
            try r.commitWrite()
        } catch let error {
            NSLog("Realm error")
            NSLog("  error: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    /**
     Updates the property of an entity.
     
     - parameter block: The block containing actions to perform.
     - throws: an `NSError` if the transaction could not be completed successfully or propagates errors generated by `block`
     */
    public func write(_ block: (() throws -> Void)) throws {
        guard let r = realm else {
            return
        }
        r.beginWrite()
        do {
            try block()
        } catch let error {
            if r.isInWriteTransaction {
                r.cancelWrite()
            }
            
            throw error
        }
        if r.isInWriteTransaction {
            try r.commitWrite()
        }
    }
    /**
     Removes a specific entity.
     
     - parameter entity: the entity that should be removed
     
     - returns:
     - `true` if the entity has been removed
     - `false` otherwise
     */
    public func delete<T: Object>(entity: T) -> Bool {
        guard let r = realm else {
            return false
        }
        
        do {
            try r.write {
                r.delete(entity)
            }
        } catch let error {
            NSLog("Realm error")
            NSLog("  error: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    public func deleteAll() -> Bool {
        guard let r = realm else {
            return false
        }
        
        do {
            try r.write {
                r.deleteAll()
            }
        } catch let error {
            NSLog("Realm error")
            NSLog("  error: \(error.localizedDescription)")
            return false
        }
        return true
    }
}

extension Object {
    func store(update: Bool = false) -> Bool {
        return Database.shared.add(entity: self, update: update)
    }
    class func count<T: Object>(entitiesOfType entityType: T.Type, where predicate: NSPredicate? = nil) -> Int {
        return (Database.shared.query(entitiesOfType: entityType, where: predicate)?.count ?? 0)
    }
    class func all<T: Object>(where predicate: NSPredicate? = nil) -> [T] {
        guard let results: Results<T> = Database.shared.query(entitiesOfType: T.self, where: predicate) else {
            return []
        }
        
        return Array(results)
    }
    class func get<T: Object>(withKeyNamed keyName: String, value: String) -> T? {
        let predicate = NSPredicate(format: "\(keyName) == %@", value)
        guard let results: Results<T> = Database.shared.query(entitiesOfType: T.self, where: predicate), results.count == 1 else {
            return nil
        }
        
        return results.first
    }
    func delete() -> Bool {
        return Database.shared.delete(entity: self)
    }
}

class RealmString: Object {
    var value = ""
}

