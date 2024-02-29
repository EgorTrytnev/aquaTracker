//
//  BodyAqua.swift
//  GlassFish
//
//  Created by user on 27.03.2023.
//

import Foundation
import UIKit


protocol bodyAquaProtocol{
    var sizeX: Int {get}
    var sizeY: Int {get}
    var sizeZ: Int {get}
    
    var nameAqua: String {get}
    var typeWater: Bool {get}
    var identAqu: Int16 {get}
    
}
protocol FishAquaProtocol{

    var nameFish: String {get set}
    
    var typeFish: TypeOfFish {get}
    
    var typeWater: TypeWater {get}
    
    var description: String {get set}
    
    var breedOfFish: String {get}
    
    var feeding: String {get}
    
    var fishContent : String {get set}
    
    var reproduction: String {get}
    
    var compatibilityText: String {get set}
    
    var compatibility: [String] {get set}
    
    var familysFishName: FamilysFishEnum {get}
    
    var identFish: Int16 {get}
    
    var waterVolume: String {get}
    
    var kind: [KindFishProtocol] {get set}
    
    var fishImage: String {get set}
    
}
protocol KindFishProtocol{
    var nameKind: String {get set}
    var textAboutKind: String {get set}
    var fishContent: String {get}
    var imageKind: String {get set}
    var waterVolume: String {get}
    var parametersWater: parametersWaterProtocol {get}
    
    var compatibility: compatibilityProtocol {get}
    
    var identFish: Int16 {get}
    
}
protocol parametersWaterProtocol{
    var tem: String {get set}
    var pH: String {get set}
    var waterHardness: String {get set}
}
protocol compatibilityProtocol{
    var compatibilityText: String {get}
    var compatibility: [String] {get}
}

struct compatibility: compatibilityProtocol{
    var compatibilityText: String
    
    var compatibility: [String]
    
    
}

struct parametersWater: parametersWaterProtocol{
    var tem: String
    
    var pH: String
    
    var waterHardness: String
    
}


struct BodyAqua: bodyAquaProtocol {
    var identAqu: Int16
    
    var sizeX: Int
    
    var sizeY: Int
    
    var sizeZ: Int
    
    var nameAqua: String
    
    var typeWater: Bool
    
}


struct FishAqua: FishAquaProtocol{
    
    
    var familysFishName: FamilysFishEnum
    
    var identFish: Int16
    
    var fishImage: String
    
    var nameFish: String
    
    var typeFish: TypeOfFish
    
    var typeWater: TypeWater
    
    var description,
        breedOfFish,
        feeding,
        fishContent,
        reproduction: String
    var compatibilityText: String
    var compatibility: [String]
    var parametersWater: parametersWaterProtocol
    var waterVolume: String
    var kind: [KindFishProtocol]
    
    
    
    
    
   
    //var viewDraw: UIImageView
    
    
}
struct KindFish: KindFishProtocol{
    
    var imageKind: String
    
    var nameKind: String
    
    var textAboutKind: String
    
    var fishContent: String
    
    var compatibility: compatibilityProtocol
    
    var waterVolume: String
    
    var parametersWater: parametersWaterProtocol
    
    var identFish: Int16
    
    
}


enum TypeWater: Int  {
    // обычная
    case soilWater
    // важная
    case water
}
enum TypeOfFish: Int{
    //хищная
    case predatorFish
    //не хищная
    case notPredatorFish
    //экзотичная 
    case exoticFish
}

enum FamilysFishEnum{
    case Cichlids,
    Carp,
    Poeciliaceae,
    Characinaceae,
    Atherine,
    Pomacentral,
    carp_toothed,
    Labyrinthine,
    Rainbows,
    Catfish,
    Sturgeon,
    Cobitidae,
    Pufferfish
}





