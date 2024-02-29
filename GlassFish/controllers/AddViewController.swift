//
//  AddViewController.swift
//  GlassFish
//
//  Created by user on 27.03.2023.
//

import UIKit
import CoreData
protocol UpdatingDataController: AnyObject{
    var editAqua: bodyAquaProtocol {get set}
    var boolEditAqua: Bool {get}
    
}
protocol CoreDateFunc{
    func saveAqua()
    func ifSaveAqua()
    func delAqua()
    
}

class AddViewController: UIViewController, UpdatingDataController, UITextFieldDelegate, CoreDateFunc {

    var editAqua: bodyAquaProtocol = BodyAqua(identAqu: 0, sizeX: 0, sizeY: 0, sizeZ: 0, nameAqua: "", typeWater: true)
    var boolEditAqua: Bool = false
    var ind: Bool = false
    
    var coordX: Int? = nil
    var coordY: Int? = nil
    var coordZ: Int? = nil
    var nameAqua = String()
    var typeWater = Bool()
    
    var numInAqua: Int = 0
    var freeIdent: [Int] = [1,2,3,4,5]
    var testIdent: [Int] = []
    var isUsedNow = Int16()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        
        
        
    }
    func backButtonNav(){
        var alertSave = UIAlertController(title: "Хотете сохранить: \(NameAquaField.text ?? "")?", message: nil, preferredStyle: .actionSheet)
        if boolEditAqua{
            alertSave = UIAlertController(title: "Хотете сохранить изменения?", message: nil, preferredStyle: .actionSheet)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        let alertActionDel = UIAlertAction(title: "Yes", style: .destructive){ action in
            self.ifSaveAqua()
            
            
        }
        let alertNotDel = UIAlertAction(title: "No", style: .default){action in
            self.navigationController?.popViewController(animated: true)
        }
        alertSave.addAction(alertActionDel)
        alertSave.addAction(alertNotDel)
        
        
        self.present(alertSave, animated: true)
    }
    
    @IBAction func buttonBackWithAlert(_ sender: Any) {
       
        
        if NameAquaField.text == "", !boolEditAqua{
            navigationController?.popViewController(animated: true)
        }
        // Проверка на редактирование
        else if boolEditAqua, nameAqua == NameAquaField.text , coordX ?? 0 == Int(CoordX.text!) , coordY ?? 0 == Int(CoordY.text!) , coordZ ?? 0 == Int(CoordZ.text!){
            navigationController?.popViewController(animated: true)
        }
        backButtonNav()
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

        addAqua()
        thereIsIdent()
        print("the",testIdent)
        print("Free",freeIdent)
        print("Num In aqua",numInAqua)
        checkImage()
        assignValue()
        
        

        
        
        
        
    }

    
    func checkImage(){
        if boolEditAqua {
            SaveOrDelButton.image = UIImage(systemName: "trash")
            SaveOrDelButton.tintColor = .red
        }else{
            SaveOrDelButton.image = .add
        }
    }





    @IBOutlet var CoordX: UITextField!
    
    @IBOutlet var CoordY: UITextField!
    
    @IBOutlet var CoordZ: UITextField!
    
    @IBOutlet var NameAquaField: UITextField!
    
    @IBOutlet var SaveOrDelButton: UIBarButtonItem!
    
   
    

    
    
    
// сортировка из кор даты
    
    func thereIsIdent(){
        testIdent.sort()
        for i in testIdent{
            if freeIdent.contains(i){
                freeIdent.remove(at: freeIdent.firstIndex(of: i) ?? 0)
            }
        }
    }
    
    
    // удаление или сохранение
    @IBAction func SaveOrDelButton(_ sender: Any) {
        if !boolEditAqua{
            
            ifSaveAqua()
        }else{
            let alertDel = UIAlertController(title: "Хотете удалить: \(NameAquaField.text ?? "")?", message: nil, preferredStyle: .alert)
            //delAqua()
            let alertActionDel = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.delAqua()
            }
            let alertNotDel = UIAlertAction(title: "No", style: .default)
            alertDel.addAction(alertActionDel)
            alertDel.addAction(alertNotDel)
            
            
            self.present(alertDel, animated: true)
        }
        
    }
    

    
    func assignValue(){
        coordX = Int(CoordX.text ?? "0")
        coordY = Int(CoordY.text ?? "0")
        coordZ = Int(CoordZ.text ?? "0")
        nameAqua = NameAquaField.text ?? ""
        
        
    }
    func saveAqua() {
        assignValue()
        if freeIdent.isEmpty == false{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
     
 
        guard let entity =  NSEntityDescription.entity(forEntityName: "AquaStor", in: managedContext) else{return}
        
        let taskObject = AquaStor(entity: entity, insertInto: managedContext)
        
            freeIdent.sort()
            taskObject.nameAqaua = nameAqua
            taskObject.coordX = Int16(coordX!)
            taskObject.coordY = Int16(coordY!)
            taskObject.coordZ = Int16(coordZ!)
            taskObject.typeWater = typeWater
            taskObject.identiferAqua = Int16(freeIdent[0])
            do{
                try managedContext.save()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }else{
            print("not free ident")
        }
     

    }
    //MARK: Кнопки сохранить и удалить
    func ifSaveAqua(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        for (_, element) in editScreen.aquaArr.enumerated(){
        
            if element.nameAqua == NameAquaField.text, !boolEditAqua{
                editScreen.boolEditN = boolEditAqua
                ind = true
               break
            }else if element.nameAqua != NameAquaField.text, !boolEditAqua{
                editScreen.boolEditN = boolEditAqua
                ind = false
                continue
            }else if element.nameAqua != NameAquaField.text, boolEditAqua{
                editScreen.boolEditN = boolEditAqua
                continue
            }else if element.nameAqua == NameAquaField.text, boolEditAqua{
                editScreen.boolEditN = boolEditAqua

                continue
            
            }
            return
           
        }
        if ind {
            
            let alert = UIAlertController(
                            title: "Такое имя уже используется",
                            message: "",
                            preferredStyle: .alert)
            let actionA = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionA)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }else {
            

            if !boolEditAqua{
                saveAqua()
                
            }else {
                assignValue()
                editScreen.loadAqua()
                editScreen.numAqua = Int(isUsedNow - 1)
                editScreen.setValueAqua(name: nameAqua, typeWater: typeWater, coordX: coordX!, coordY: coordY!, coordZ: coordZ!)
                
            }
            
            

            
            
        }
        navigationController?.popViewController(animated: true)
        
    }
    func delAqua(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchName: NSFetchRequest<AquaStor> = AquaStor.fetchRequest()
        let fetchNameFish: NSFetchRequest<FishStor> = FishStor.fetchRequest()
        
        if let aqua = try? managedContext.fetch(fetchName){
                managedContext.delete(aqua[numInAqua])
        }
        if let fish = try? managedContext.fetch(fetchNameFish){
            for i in fish{
                if i.identiferFish == isUsedNow{
                    managedContext.delete(i)
                }
            }
        }
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //Установка значений и редактирование
    private func addAqua() {
        
        CoordX.text = String(editAqua.sizeX)
        CoordY.text = String(editAqua.sizeY)
        CoordZ.text = String(editAqua.sizeZ)
        NameAquaField.text = editAqua.nameAqua

    }
//MARK: работа с клавиатурой
    
    private func addNotification(){
        NameAquaField.delegate = self
        CoordX.delegate = self

        NotificationCenter.default.addObserver(forName: AddViewController.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            if self.NameAquaField.isEditing == false{
                self.view.frame.origin.y = -200

                
            }
        }
        NotificationCenter.default.addObserver(forName: AddViewController.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
           
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.NameAquaField.resignFirstResponder()
        self.CoordX.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.CoordX.resignFirstResponder()
        self.CoordY.resignFirstResponder()
        self.CoordZ.resignFirstResponder()
        return true
    }


    
    @IBAction func CloseKeyboard(_ sender: Any) {
        self.CoordX.resignFirstResponder()
        self.CoordY.resignFirstResponder()
        self.CoordZ.resignFirstResponder()
        self.view.frame.origin.y = 0.0
        print("jso  mksqmkxq")
        
    }
    
}
