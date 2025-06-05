//
//  LocalDataSource.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 01/06/2025.
//


import Foundation
import CoreData
import UIKit


class LocalDataSouce {
    
    
    static func addToFavorites(favoriteLeague: FavoriteLeague) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            
                guard let entity = NSEntityDescription.entity(forEntityName: "FavorteLeaguesV1", in: context) else {
                    print("Entity not found")
                    return
                }
                
                let managedObject = NSManagedObject(entity: entity, insertInto: context)
                managedObject.setValue(favoriteLeague.leagueName, forKey: "leagueName")
                managedObject.setValue(favoriteLeague.endPoint, forKey: "endPoint")
                managedObject.setValue(favoriteLeague.leagueImageUrl, forKey: "leagueImageUrl")

                
            do {
                try context.save()
                print("Successfully saved \(favoriteLeague) ")
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }

static func getFavoriteLeague() -> [FavoriteLeague] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavorteLeaguesV1")
        var favoriteLeagues:[FavoriteLeague] = []
        do {
            let localNews = try context.fetch(fetchRequest)
            for item in localNews {
                let localFavoriteLeague = FavoriteLeague(leagueName: "", leagueImageUrl: "", endPoint: "")
                print("data from local database -> ")
                localFavoriteLeague.endPoint = item.value( forKey: "endPoint") as! String
                localFavoriteLeague.leagueName = item.value( forKey: "leagueName") as! String
                localFavoriteLeague.leagueImageUrl = item.value( forKey: "leagueImageUrl") as! String
                favoriteLeagues.append(localFavoriteLeague)
            }
            
            
        } catch {
            print("Can't get data: \(error.localizedDescription)")
        }
        return favoriteLeagues
    }
    
    static func deleteFromFavorites(leagueName: String) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            // Create a fetch request to find the league to delete
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavorteLeaguesV1")
            fetchRequest.predicate = NSPredicate(format: "leagueName == %@", leagueName)
            
            do {
                let results = try context.fetch(fetchRequest)
                
                // If we found the league, delete it
                if let leagueToDelete = results.first as? NSManagedObject {
                    context.delete(leagueToDelete)
                    
                    // Save the context
                    try context.save()
                    print("Successfully deleted league with name: \(leagueName)")
                }
            } catch {
                print("Error deleting league: \(error.localizedDescription)")
            }
        }
    }
    
    static func isLeagueFavorited(leagueName: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavorteLeaguesV1")
        
        fetchRequest.predicate = NSPredicate(format: "leagueName ==[c] %@", leagueName)
        
        do {
            let results = try context.fetch(fetchRequest)
            print("True True True----------->>>>>>\(!results.isEmpty) ")
            return !results.isEmpty
        } catch {
            print("Error checking favorite status: \(error.localizedDescription)")
            return false
        }
    }

   
    }
    

