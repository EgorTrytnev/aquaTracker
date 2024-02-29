//
//  ViewController.swift
//  GlassFish
//
//  Created by user on 21.03.2023.
//

import UIKit
import CoreData

protocol CoreDateDownloadAqua{
    var aquaArr: [BodyAqua] {get}
    var userAquaCore: [AquaStor] {get}
    
    func loadAqua()
    func setValueAqua(name: String, typeWater: Bool, coordX: Int, coordY: Int, coordZ: Int)
}


class ViewController: UIViewController{

    
    var tasksStorage = StrorageAqua()

    var aquaArr: [BodyAqua] = []
    var identifierArr: [Int] = [50,50,50,50,50]
    var userAquaCore: [AquaStor] = []
    var numAqua: Int = 0
    
    var boolEditN: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        loadAqua()
        loadWorkArr()
        
        if numAqua > aquaArr.count - 1, aquaArr.count - 1 != -1{
            print("Out of range")
            numAqua -= 1
        }
        reloadButtons()
        addAqua()
        print("the ident",identifierArr)
        print(numAqua)
        
        
    }
    
    func loadWorkArr(){
        for i in userAquaCore{
            aquaArr.append(BodyAqua(identAqu: i.identiferAqua, sizeX: Int(i.coordX), sizeY: Int(i.coordY), sizeZ: Int(i.coordZ), nameAqua: i.nameAqaua ?? "", typeWater: i.typeWater))
            
        }
        var ind = 0
        identifierArr = [50,50,50,50,50]
        
        for i in userAquaCore{
            if identifierArr.contains(50){
                identifierArr[ind] = Int(i.identiferAqua)
                ind += 1
            }
        }
        
        
        
    }



    // Outlets________________________________
    
    @IBOutlet var SizeAqua: UIImageView!
    
    @IBOutlet var SizeAquaSmaal: UIImageView!
    
    @IBOutlet var NameAqua: UILabel!
    
    @IBOutlet var LableCoordX: UILabel!
    
    @IBOutlet var LableCoordY: UILabel!
    
    @IBOutlet var LableCoordZ: UILabel!
    
    
    
    @IBOutlet var OutlenNextAqua: UIButton!
    @IBOutlet var OutlenDownAqua: UIButton!
    
    
    @IBOutlet var ButtonEdit: UIButton!
    
    
    // Actions button_____________________________
    
    @IBAction func AddAqua(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "AddController") as! AddViewController
        editScreen.boolEditAqua = false
        editScreen.numInAqua = aquaArr.count
        editScreen.testIdent = identifierArr
        
        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    @IBAction func LookAtFish(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "FishList") as! FishList
        
        editScreen.numInAqua = numAqua
        
        
        navigationController?.pushViewController(editScreen, animated: true)

    }
    
    //Edit___________________________
    
    @IBAction func EditAquaUp(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "AddController") as! AddViewController
        editScreen.editAqua = aquaArr[numAqua]
        editScreen.boolEditAqua = true
        editScreen.numInAqua = numAqua
        editScreen.isUsedNow = userAquaCore[numAqua].identiferAqua
        
        navigationController?.pushViewController(editScreen, animated: true)
        UIView.animate(withDuration: 0.1){
            self.SizeAqua.alpha = 1
            self.SizeAquaSmaal.alpha = 0
        }
    }
    
    @IBAction func ButtonEditDown(_ sender: Any) {
        UIView.animate(withDuration: 0.1){
            self.SizeAqua.alpha = 0
            self.SizeAquaSmaal.alpha = 1
        }
    }
    //_________________________________
    
    
    @IBAction func addFishButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "familysViewContr") as! familysFishTableView
        
        if aquaArr.isEmpty == false{
            editScreen.numInAqua = Int(aquaArr[numAqua].identAqu)
            navigationController?.pushViewController(editScreen, animated: true)
        }else{
            let alert = UIAlertController(
                            title: "Сначала создай аквариум",
                            message: "",
                            preferredStyle: .alert)
            let actionA = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionA)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    // Обработка кнопок влево/право

        @IBAction func NextAqua(_ sender: Any) {
            
            numAqua += 1
            addAqua()
            reloadButtons()
            AddViewController().numInAqua = aquaArr.count
            
            print(numAqua)
            print("the ident",userAquaCore[numAqua].identiferAqua)
            
        }
        
        
        @IBAction func DownAqua(_ sender: Any) {

            numAqua -= 1
            addAqua()
            reloadButtons()
            AddViewController().numInAqua = aquaArr.count
            print("the ident",userAquaCore[numAqua].identiferAqua)
            
            
        }
    
    
    
    // Загрузка и обработка аквариумов
    func loadAqua(){
        aquaArr.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchName: NSFetchRequest<AquaStor> = AquaStor.fetchRequest()
       
        
        do{
            userAquaCore = try managedContext.fetch(fetchName)
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        print(userAquaCore)
    }
    
    func setValueAqua(name: String, typeWater: Bool, coordX: Int, coordY: Int, coordZ: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
        
        userAquaCore[numAqua].setValue(name, forKey: "nameAqaua")
        userAquaCore[numAqua].setValue(typeWater, forKey: "typeWater")
        userAquaCore[numAqua].setValue(coordX, forKey: "coordX")
        userAquaCore[numAqua].setValue(coordY, forKey: "coordY")
        userAquaCore[numAqua].setValue(coordZ, forKey: "coordZ")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    

    

    
    //Работа с интерфейсом

    private func reloadButtons(){
        if numAqua == 0 || aquaArr.isEmpty{
            OutlenDownAqua.isEnabled = false
        }else{
            OutlenDownAqua.isEnabled = true
        }
        if numAqua + 1 == aquaArr.count || aquaArr.isEmpty {
            OutlenNextAqua.isEnabled = false
        }else{
            OutlenNextAqua.isEnabled = true
        }
        if aquaArr.isEmpty{
            ButtonEdit.isHidden = true
        }else{
            ButtonEdit.isHidden = false
        }
    }
    
    private func addAqua() {
        let numAquaI = Int(numAqua)
            
        if aquaArr.isEmpty == false{
            LableCoordX.text = "Длинна: \(String(aquaArr[numAquaI].sizeX))"
            LableCoordY.text = "Высота: \(String(aquaArr[numAquaI].sizeY))"
            LableCoordZ.text = "Ширина: \(String(aquaArr[numAquaI].sizeZ))"
            NameAqua.text = aquaArr[numAquaI].nameAqua
        }
        



    }
    
   
}

