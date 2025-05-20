import UIKit
import CoreData

class LeagueLocalSource: LeagueLocalSourceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    func insertLeague(league: League) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.leagueKey ?? -1)
        
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                return .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "League already exists"]))
            }
            
            // 2. Insert if not found
            guard let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: context) else {
                return .failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "Entity not found"]))
            }
            
            let leagueEntity = NSManagedObject(entity: entity, insertInto: context)
            leagueEntity.setValue(league.leagueKey, forKey: "leagueKey")
            leagueEntity.setValue(league.leagueName, forKey: "leagueName")
            leagueEntity.setValue(league.countryKey, forKey: "countryKey")
            leagueEntity.setValue(league.countryName, forKey: "countryName")
            leagueEntity.setValue(league.leagueLogo, forKey: "leagueLogo")
            leagueEntity.setValue(league.countryLogo, forKey: "countryLogo")
            leagueEntity.setValue(league.sportType, forKey: "sportType")
            try context.save()
            return .success(())
            
        } catch {
            return .failure(error)
        }
    }
    
    func deleteLeague(league: League) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.leagueKey ?? -1)
        
        do {
            if let results = try context.fetch(fetchRequest) as? [NSManagedObject],
               let leagueEntity = results.first {
                context.delete(leagueEntity)
                try context.save()
                return .success(())
            } else {
                return .failure(NSError(domain: "CoreData", code: 404, userInfo: [NSLocalizedDescriptionKey: "League not found"]))
            }
        } catch {
            return .failure(error)
        }
    }
    
    func getAllLeagues() -> Result<[League], Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            let leagues: [League] = results.map { obj in
                League(
                    leagueKey: obj.value(forKey: "leagueKey") as? Int,
                    leagueName: obj.value(forKey: "leagueName") as? String,
                    countryKey: obj.value(forKey: "countryKey") as? Int,
                    countryName: obj.value(forKey: "countryName") as? String,
                    leagueLogo: obj.value(forKey: "leagueLogo") as? String,
                    countryLogo: obj.value(forKey: "countryLogo") as? String,
                    sportType: obj.value(forKey: "sportType") as? String
                )
            }
            
            return .success(leagues)
        } catch {
            return .failure(error)
        }
    }
}
