//
//  StorageAqua.swift
//  GlassFish
//
//  Created by user on 30.03.2023.
//

import Foundation



protocol storageAquaProtocol {
    func filterFishAll(typeFish: TypeOfFish?, typeWater: TypeWater?)
}

class StrorageAqua: storageAquaProtocol {
    
    
    var allFishArray: [FishAquaProtocol] = []
    var filterFish: [FishAquaProtocol] = []
    var usersFishArr: [FishAquaProtocol] = []
    
    
    
    var familySFishArr: [FishAquaProtocol] = []
    
    
    var nameFishStr: [String] = []
    

    
    func replaceKindFishOn(){
      
        for i in loadFish(){
            for f in i.kind{
                if i.kind.isEmpty == false{
                    var fish: FishAquaProtocol
                    fish = i
                    
                    fish.nameFish = f.nameKind
                    fish.fishImage = f.imageKind
                    fish.description = f.textAboutKind
                    if f.nameKind == ""{
                        fish.nameFish = " "
                        print("THEEEEE",i.nameFish)
                    }
                    
                    allFishArray.append(fish)
                    
                }else{
                    print("Kind is Empty!!!")
                }
            }

        }
    }
        
        func loadFishLibrary(){
            allFishArray.removeAll()
            
            loadFish().forEach {fish in
                allFishArray.append(fish)
                
            }
            replaceKindFishOn()
        }
    
    func loadNameFishStr() -> [String]{
        var str: [String] = []
        loadFish().forEach{ name in
            str.append(String(name.nameFish.lowercased()))
        }
        return str
    }
        
    func filterFishFind(text:String, fishArr: [FishAquaProtocol]){
            filterFish.removeAll()
            
            filterFish = fishArr.filter({(fish) -> Bool in

                if fish.nameFish.lowercased().contains(text.lowercased()){
                    
                   return fish.nameFish.lowercased().contains(text.lowercased())
                    
                }
                
                return false
                
            })
            
        }
    
    //заполняем массив для семейств рыб
    func filerFishFamilys(familyFish: FamilysFishEnum){
        var newFishName: [FishAquaProtocol] = []
        allFishArray.forEach{ fish in
            if fish.familysFishName == familyFish{
                newFishName.append(fish)
                
            }
            
        }
        familySFishArr = newFishName
    }
        
        
        var testFishArr: [FishAquaProtocol] = []
        func filterFishAll(typeFish: TypeOfFish?, typeWater: TypeWater?){
            testFishArr.removeAll()
            
            for fish in allFishArray{
                if typeFish == .notPredatorFish, typeWater == nil{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }
                else if typeFish == .predatorFish, typeWater == nil{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }else if typeFish == .exoticFish, typeWater == nil{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }else if typeFish == nil, typeWater == .water{
                    if fish.typeWater == typeWater{
                        testFishArr.append(fish)
                    }
                }
                else if typeFish == nil, typeWater == .soilWater{
                    if fish.typeWater == typeWater{
                        testFishArr.append(fish)
                    }
                }else if typeFish == .exoticFish, typeWater == .soilWater || typeWater == .water {
                    if fish.typeWater == typeWater, typeFish == fish.typeFish{
                        testFishArr.append(fish)
                    }
                }else if typeFish == .predatorFish, typeWater == .soilWater || typeWater == .water {
                    if fish.typeWater == typeWater, typeFish == fish.typeFish{
                        testFishArr.append(fish)
                    }
                }else if typeFish == .notPredatorFish, typeWater == .soilWater || typeWater == .water {
                    if fish.typeWater == typeWater, typeFish == fish.typeFish{
                        testFishArr.append(fish)
                    }
                }
                filterFish = testFishArr
            }
        }
        func filterFishTable(typeFish: TypeOfFish){
            testFishArr.removeAll()
            
            for fish in allFishArray{
                if typeFish == .notPredatorFish{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }
                else if typeFish == .predatorFish{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }else if typeFish == .exoticFish{
                    if fish.typeFish == typeFish{
                        testFishArr.append(fish)
                    }
                }
                filterFish = testFishArr
                
            }
        }
        var typeWaterArr: [FishAquaProtocol] = []
        func filterFishWater(typeWater: TypeWater){
            
            typeWaterArr.removeAll()
            for f in allFishArray{
                if typeWater == .water{
                    if f.typeWater == typeWater{
                        
                        typeWaterArr.append(f)
                    }
                }else if typeWater == .soilWater{
                    if f.typeWater == typeWater{
                        typeWaterArr.append(f)
                    }
                }
                
                filterFish = testFishArr + typeWaterArr
                
                
            }

            
        }
        

        //Вся рыба
        func loadFish() -> [FishAquaProtocol]{
            let fishStorage: [FishAquaProtocol] = [
                FishAqua(familysFishName: .Characinaceae, identFish: 0, fishImage: "", nameFish: "Fish", typeFish: .notPredatorFish, typeWater: .soilWater,
                         description: "",
                         
                         breedOfFish: "",
                         
                         feeding: "",
                         
                         fishContent: "",
                         
                         reproduction: "",
                         
                         compatibilityText: "",
                         
                         compatibility: [""], parametersWater: parametersWater(tem: "", pH: "", waterHardness: ""), waterVolume: "", kind: [] ),
                
                
                FishAqua(familysFishName: .Characinaceae, identFish: 0, fishImage: "", nameFish: "Fish", typeFish: .notPredatorFish, typeWater: .soilWater,
                         description: "",
                         
                         breedOfFish: "",
                         
                         feeding: "",
                         
                         fishContent: "",
                         
                         reproduction: "",
                         
                         compatibilityText: "",
                         
                         compatibility: [""], parametersWater: parametersWater(tem: "", pH: "", waterHardness: ""), waterVolume: "", kind: [] ),
                
                FishAqua(familysFishName: .Characinaceae, identFish: 0, fishImage: "", nameFish: "Fish", typeFish: .notPredatorFish, typeWater: .soilWater,
                         description: "",
                         
                         breedOfFish: "",
                         
                         feeding: "",
                         
                         fishContent: "",
                         
                         reproduction: "",
                         
                         compatibilityText: "",
                         
                         compatibility: [""], parametersWater: parametersWater(tem: "", pH: "", waterHardness: ""), waterVolume: "", kind: [] )
                
                
                
                
            ]
            
            return fishStorage
        }
        func addInUsersArr(fish: FishAqua){
            usersFishArr.append(fish)
            print(usersFishArr)
            
        }
        
        
        
        
        
        
    }


    
