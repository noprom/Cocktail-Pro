//
//  DataDAO.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/6.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

class DataDAO {
    
    //获取单个的酒单
    class func getOneRecipe(id:Int) -> Recipe{
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: managedObjectContext)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        var error: NSError? = nil
        var items:[Recipe] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Recipe]
        if(items.count==0){
            abort()
        }else{
            return items[0]
        }
    }
    //获取单个的酒单
    class func updateRecipeCoverd(ingredientId:Int,SetHave sethave:Bool){
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("RecipeStep", inManagedObjectContext: managedObjectContext)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "ingridientId == \(ingredientId) AND stepType == 0")
        var error: NSError? = nil
        var recipeSteps = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [RecipeStep]
        if(recipeSteps.count != 0){//该材料有绑定，需要更新
            for recipestep:RecipeStep in recipeSteps {
                //找到对应的recipe
                var recipe = getOneRecipe(recipestep.recipeId.integerValue)
                recipestep.cover = sethave
                //找到该酒单下的为important的sistor
                let fetchsistor = NSFetchRequest()
                fetchsistor.entity = NSEntityDescription.entityForName("RecipeStep", inManagedObjectContext: managedObjectContext)
                fetchsistor.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
                fetchsistor.predicate = NSPredicate(format: "recipeId == \(recipestep.recipeId) AND important == true")
                var error: NSError? = nil
                var sistorSteps = managedObjectContext.executeFetchRequest(fetchsistor, error: &error) as [RecipeStep]
                if(sistorSteps.count != 0){//有标记位重要的
                    var numcover:CGFloat = 0
                    for sistor:RecipeStep in sistorSteps {
                        if(sistor.cover == true){
                            numcover++
                        }
                    }
                    recipe.coverd = numcover/CGFloat(sistorSteps.count)
                }else{//没有标记为重要的
                    recipe.coverd = 0
                }
            }
        }
        if !managedObjectContext.save(&error) {
            abort()
        }
    }
    //获取单个的容器
    class func getOneContainer(id:Int) -> Container{
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Container", inManagedObjectContext: managedObjectContext)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        var error: NSError? = nil
        var items:[Container] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Container]
        if(items.count==0){
            abort()
        }else{
            return items[0]
        }
    }
    //获取单个的材料
    class func getOneIngridient(id:Int) -> Ingridient{
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Ingridient", inManagedObjectContext: managedObjectContext)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        var error: NSError? = nil
        var items:[Ingridient] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Ingridient]
        if(items.count==0){
            abort()
        }else{
            return items[0]
        }
        
    }
}
