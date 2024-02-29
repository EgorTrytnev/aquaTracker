//
//  DescriptionViewController.swift
//  GlassFish
//
//  Created by user on 11.04.2023.
//

import UIKit
import CoreData
import DropDown
import TappableLabelView

protocol nameAndIdentProt{
    var name: String {get}
    var ident: Int16 {get}
}
struct nameAndIdent: nameAndIdentProt{
    var name: String
    
    var ident: Int16
    
}

class DescriptionViewController: UIViewController, TappableLabelViewDelegate, UITableViewDelegate, UITableViewDataSource{

    


    
    
    var fishStor = StrorageAqua()
    let dropMenu = DropDown()
    var nameFishArr: [FishStor] = []
    var nameFishStr: [nameAndIdent] = []

    var numInAqua: Int = 0
    
    var breedFish = UITextView()
    
    var tappableLabelView1: TappableLabelView!
    var tappableLabelView2: TappableLabelView!
    var tappableLabelView3: TappableLabelView!
    
    
    
    var storageDes: FishAquaProtocol = FishAqua( familysFishName: .Atherine, identFish: 0, fishImage: "", nameFish: "", typeFish: .predatorFish, typeWater: .soilWater, description: "", breedOfFish: "", feeding: "", fishContent: "", reproduction: "", compatibilityText: "", compatibility: [""], parametersWater: parametersWater(tem: "", pH: "", waterHardness: ""), waterVolume: "", kind: [])
    
    @IBOutlet var LableDescription: UILabel!
    
    @IBOutlet var NameFish: UILabel!
    
    @IBOutlet var FishContent: UILabel!
    
    @IBOutlet var feeding: UILabel!
    
    

    @IBOutlet var ImageView: UIImageView!
    
    @IBOutlet var ButtonDropDownMenu: UIBarButtonItem!
    
    @IBOutlet var ViewForButton: UIView!
    
    //Контент контроллера
    
    @IBOutlet var StandartView: UIView!
    
    @IBOutlet weak var HightStandartView: NSLayoutConstraint!
    
    @IBOutlet var BreedView: UIView!
    
    @IBOutlet weak var HightViewBreed: NSLayoutConstraint!
    

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var mainViewHight: NSLayoutConstraint!
    
    
    
    
    @IBOutlet var AllButtonView: [UIButton]!
    
    //Совместимость
    
    @IBOutlet var fishСompatibility: UIView!
    
    var compatibilityFish = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownMenu()
        
        
        tapLable(typeFishCompat: storageDes.compatibilityText, typeFishCompatArr: storageDes.compatibility, ancerView: fishСompatibility, tappaLab: tappableLabelView1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStandartShadows(object: StandartView)
        setStandartShadows(object: BreedView)
        setStandartShadows(object: ViewForButton)
        setStandartShadows(object: mainView)
        
        setViewCompatibility()
        

        

     
        fishStor.loadFishLibrary()
        //изменение вью совместимости
        

        super.viewWillAppear(animated)
        AllButtonView[0].backgroundColor = .systemGray5
        
        for i in AllButtonView{
            i.layer.cornerRadius = 5
            
        }

        LableDescription.text = storageDes.description
        feeding.text = storageDes.feeding
        FishContent.text = storageDes.fishContent
        NameFish.text = storageDes.nameFish
        ImageView.image = UIImage(named: storageDes.fishImage)
        ImageView.layer.cornerRadius = 12
        

        

        
        
        loadFish()
        for i in nameFishArr{
            nameFishStr.append(nameAndIdent(name: i.fishName ?? "", ident: i.identiferFish))
        }
        print("THEEEEEEE",nameFishStr)

        
    }
    
    func setStandartShadows(object: AnyObject){
        object.layer.cornerRadius = 5
        object.layer.shadowRadius = 1
        object.layer.shadowOpacity = 0.3
    }
    private func setHightView(){
        if storageDes.kind.count != 0{
            if storageDes.kind.count == 1{
                mainViewHight.constant = 800
            }else{
                if storageDes.kind.count > 15{
                    mainViewHight.constant = CGFloat(storageDes.kind.count*300 - 150)
                    HightViewBreed.constant = CGFloat(storageDes.kind.count*300 - 150)
                }else{
                    mainViewHight.constant = CGFloat(storageDes.kind.count*300 + 300)
                    HightViewBreed.constant = CGFloat(storageDes.kind.count*300 + 300)
                }
            }
        }else {
            mainViewHight.constant = 800
        }
    }
    
    //Кнопки перелючения инфы
    @IBAction func ReproductionButton(_ sender: Any) {
        
        AllButtonView[3].backgroundColor = .systemGray5
        AllButtonView[2].backgroundColor = nil
        AllButtonView[1].backgroundColor = nil
        AllButtonView[0].backgroundColor = nil
        
    }
    @IBAction func WaterButton(_ sender: Any) {
        AllButtonView[3].backgroundColor = nil
        AllButtonView[2].backgroundColor = .systemGray5
        AllButtonView[1].backgroundColor = nil
        AllButtonView[0].backgroundColor = nil
    }
    @IBAction func ButtonActionBreed(_ sender: Any) {
        setHightView()
        BreedView.isHidden = false
        StandartView.isHidden = true
        AllButtonView[3].backgroundColor = nil
        AllButtonView[2].backgroundColor = nil
        AllButtonView[1].backgroundColor = .systemGray5
        AllButtonView[0].backgroundColor = nil
    }
    @IBAction func DefaultButton(_ sender: Any) {
        setViewCompatibility()
        BreedView.isHidden = true
        StandartView.isHidden = false
        AllButtonView[3].backgroundColor = nil
        AllButtonView[2].backgroundColor = nil
        AllButtonView[1].backgroundColor = nil
        AllButtonView[0].backgroundColor = .systemGray5

    }
    
    

    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageDes.kind.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KindFish", for: indexPath) as! KindFishCell
        let nameFish = storageDes.kind[indexPath.row].nameKind
        let imageFish = storageDes.kind[indexPath.row].imageKind
        
        cell.fishName.text = nameFish
        cell.myImage.image = UIImage(named: imageFish)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "DesViewContr") as! DescriptionViewController
        
        var currentCell: FishAquaProtocol!
        
        currentCell = storageDes
        currentCell.kind[indexPath.row].imageKind = storageDes.fishImage
        currentCell.kind[indexPath.row].nameKind = storageDes.nameFish
        currentCell.kind[indexPath.row].textAboutKind = storageDes.description
        currentCell.fishImage = storageDes.kind[indexPath.row].imageKind
        currentCell.nameFish = storageDes.kind[indexPath.row].nameKind
        currentCell.description = storageDes.kind[indexPath.row].textAboutKind
        currentCell.fishContent = storageDes.kind[indexPath.row].fishContent
        currentCell.compatibilityText = storageDes.kind[indexPath.row].compatibility.compatibilityText
        currentCell.compatibility = storageDes.kind[indexPath.row].compatibility.compatibility
        
        descriptionScreen.storageDes = currentCell
        navigationController?.pushViewController(descriptionScreen, animated: true)
    }

//TableView end
    
    func setViewCompatibility(){
        let countSign = CGFloat(storageDes.description.count + storageDes.feeding.count + storageDes.fishContent.count + storageDes.compatibilityText.count)
        if countSign <= 2500{
            mainViewHight.constant = countSign
        } else if countSign <= 3500{
            mainViewHight.constant = countSign
        }else if countSign <= 4500{
            mainViewHight.constant = countSign
        }else{
            mainViewHight.constant = countSign
        }
        

            
        print(countSign)
        

    }

    
    func tapLable(typeFishCompat: String, typeFishCompatArr: [String], ancerView: UIView!, tappaLab: TappableLabelView!){
        let colorFontNormal = UIColor.black
        let font = UIFont.systemFont(ofSize: 17)
        let colorFontLinc = UIColor.blue
        let fontLinc = UIFont.systemFont(ofSize: 17)
        let typeFishCom = typeFishCompat
        let nameFishArr = typeFishCompatArr
        var tapLab: TappableLabelView! = tappaLab
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: colorFontNormal
            
        ]

        
        let attributesLincText: [NSAttributedString.Key: Any] = [
            .font: fontLinc,
            .foregroundColor: colorFontLinc
        ]
        
        
        let options = ConfigurationOptions(textAttributes: attributes,
                                           highlightedTextAttributes: attributesLincText,
                                           alignment: .left,
                                           isUnderline: false,
                                           wordSpacing: 5,
                                           lineSpacing: 6,
                                           delegate: self)
        tapLab = TappableLabelView(frame: .zero, options: options)
        tapLab.translatesAutoresizingMaskIntoConstraints = false
        
        tapLab.text = typeFishCom
        tapLab.tappableStrings = nameFishArr
        

        
        ancerView.addSubview(tapLab)
        NSLayoutConstraint.activate([
            tapLab.heightAnchor.constraint(equalToConstant: setAnchorText()),
            tapLab.leadingAnchor.constraint(equalTo: ancerView.leadingAnchor, constant: 0),
            tapLab.leftAnchor.constraint(equalTo: ancerView.rightAnchor, constant: 10),
            tapLab.trailingAnchor.constraint(equalTo: ancerView.trailingAnchor, constant: 0),
            tapLab.topAnchor.constraint(equalTo: ancerView.topAnchor, constant: 0)
                   ])
    }
    func setAnchorText() -> CGFloat{
        if storageDes.compatibilityText.count < 300{
            return 250
        }else if storageDes.compatibilityText.count < 500{
            return 350
        }else if storageDes.compatibilityText.count < 700{
            return 500
        }else if storageDes.compatibilityText.count < 1000{
            return 680
        }else if storageDes.compatibilityText.count < 1400{
            return 850
        }else{
            return 1000
        }
        
    }
    
    

 
    
    @IBAction func DropDownMenu(_ sender: Any) {
        dropMenu.show()
        dropMenu.alpha = 0
        
            UIView.animate(withDuration: 0.5){
                self.dropMenu.alpha = 1
        }
    }
    

            
//Функция кликабельного лейбла
    
    func didTap(tappableLabelView: TappableLabelView, text: String, indexInText: Int, index: Int) {
        


        
  
        var myFish: String {
            var name = Substring()
            var anotherName = String()
            if text.contains(",") || text.contains(".") {
                name = text.dropLast()
                
                
                return String(name)
            }else{
                anotherName = text
                print(anotherName)
                return anotherName
            }

            
        }
        var readyName = myFish.dropLast()
        
        
            
        fishStor.filterFishFind(text: String(readyName), fishArr: fishStor.allFishArray)
        while fishStor.filterFish.count == 0, readyName.count > 3{
            fishStor.filterFishFind(text: String(readyName), fishArr: fishStor.allFishArray)
            readyName = readyName.dropLast()
            
        }
        for i in fishStor.allFishArray{
            
            if fishStor.filterFish.count != 0{
                if fishStor.filterFish[0].nameFish.lowercased() == i.nameFish.lowercased(){
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "DesViewContr") as! DescriptionViewController
                    
                    descriptionScreen.storageDes = i
                    descriptionScreen.numInAqua = numInAqua
                    
                    
                    
                    navigationController?.pushViewController(descriptionScreen, animated: true)
                }else{
                    print("Not finded fish")
                }
                
                
            }
        }
        }
    
        
    

        
    
    
    
    var addFishBool: Bool = true
    @IBAction func AddFishButton(_ sender: Any) {
        
        StrorageAqua().addInUsersArr(fish: storageDes as! FishAqua)
        
        for i in nameFishStr{
            if storageDes.nameFish == i.name, i.ident == numInAqua{
                addFishBool = false
            }
            
        }
        if addFishBool{
            saveFish(name: storageDes.nameFish)
            addFishBool = false
        }else{
            print("Уже есть!")
        }
        
      
    }
    
    private func dropDownMenu(){

        dropMenu.dataSource = ["Приспособления", "Типы воды", "Размножение"]
        dropMenu.layer.cornerRadius = 5
        dropMenu.anchorView = ButtonDropDownMenu
        dropMenu.cornerRadius = 12
        dropMenu.dimmedBackgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.15)
        dropMenu.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        
        
        dropMenu.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? TableViewCell else{
                return
            }
            cell.myImage.image = UIImage(systemName: "book")
            cell.myImage.tintColor = .black
            
        }
        
        dropMenu.bottomOffset = CGPoint(x: -170, y: 50)
        
        //Action
        
        dropMenu.selectionAction = { index, item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let more = storyboard.instantiateViewController(withIdentifier: "MoreInform") as! MoreInfo
            
            if index == 0 {
                self.navigationController?.pushViewController(more, animated: true)
            }else{
                print(item)
            }
            
            
        }
        
        

    }
    //MARK: Core Data FISH
    
    @IBAction func DeleteButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchName: NSFetchRequest<FishStor> = FishStor.fetchRequest()
        if let fish = try? managedContext.fetch(fetchName){
            for i in fish{
                if i.fishName == storageDes.nameFish, i.identiferFish == numInAqua{
                    managedContext.delete(i)
                }
            }
            
        }
        
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    
    func saveFish(name: String) {
  
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
     
 
        guard let entity =  NSEntityDescription.entity(forEntityName: "FishStor", in: managedContext) else{return}
        
        let taskObject = FishStor(entity: entity, insertInto: managedContext)
        taskObject.fishName = name
        taskObject.identiferFish = Int16(numInAqua)
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
     

    }
    
    func loadFish(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchName: NSFetchRequest<FishStor> = FishStor.fetchRequest()
       
        
        do{
            nameFishArr = try managedContext.fetch(fetchName)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        print("The", nameFishArr)
        
    }
    
    

    
    

    
    
    
    

}


