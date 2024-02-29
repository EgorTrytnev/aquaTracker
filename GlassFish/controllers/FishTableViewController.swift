//
//  FishTableViewController.swift
//  GlassFish
//
//  Created by user on 07.04.2023.
//

import UIKit


class FishTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var fishStorage = StrorageAqua()
    var searchController = UISearchController()
    var numInAqua: Int = 0
    var familysFishArray = [FishAquaProtocol]()
    
    var familyFish: FamilysFishEnum = .Atherine
    

    override func viewWillAppear(_ animated: Bool) {
        print("Это", numInAqua)
        
        initsearchController()
        setFilerButton()
        print(familyFish)
        fishStorage.loadFishLibrary()
        fishStorage.filerFishFamilys(familyFish: familyFish)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    private func initsearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        searchController.searchBar.showsScopeBar = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchBar.delegate = self
    }
   

    //нажатие по ячейке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "DesViewContr") as! DescriptionViewController
       
        let currentCell: FishAquaProtocol!
        if isSearch() || isFiltSearch{
            currentCell = fishStorage.filterFish[indexPath.row]
        }else{
            currentCell = fishStorage.familySFishArr[indexPath.row]
        }
            
        
        descriptionScreen.storageDes = currentCell
        descriptionScreen.numInAqua = numInAqua
        
        
        
        navigationController?.pushViewController(descriptionScreen, animated: true)
        
    }

   

    // MARK: - Table view data source


    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch() || isFiltSearch{
            return fishStorage.filterFish.count
        }else{
            return fishStorage.familySFishArr.count
        }
        

        
    }
    //заполнение ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "StackCell", for: indexPath) as! TableCell
        // получаем данные о задаче, которую необходимо вывести в ячейке
        
        let currentCell: FishAquaProtocol!
        if isSearch() || isFiltSearch{
            currentCell = fishStorage.filterFish[indexPath.row]
        }else{
            currentCell = fishStorage.familySFishArr[indexPath.row]
        }



        
        // изменим текст в ячейке
        if currentCell.typeFish == .exoticFish{
            cell.ViewCellFish.image = UIImage(named: "exoticFish")
        }
        else if currentCell.typeFish == .notPredatorFish{
            cell.ViewCellFish.image = UIImage(named: "normalFish")
        }
        else if currentCell.typeFish == .predatorFish{
            cell.ViewCellFish.image = UIImage(named: "predatorFish")
        }
        
        // изменим символ в ячейке
        cell.TextCell?.text = currentCell.nameFish
        

        return cell 
    }

                                         
    private func filterFishArray(text: String){
        fishStorage.filterFishFind(text: text, fishArr: fishStorage.familySFishArr)
        tableView.reloadData()
    }
    private func searchBarEmpty()-> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private func isSearch()-> Bool {
        return searchController.isActive && !searchBarEmpty()
    }


    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != ""{
            filterFishArray(text: searchController.searchBar.text!)
            
        }else{
            tableView.reloadData()
        }
        
    }
    //alert
    
    var lever = true
    var leverTypeFish = false
    @IBAction func FilterAlert(_ sender: Any) {
        
        if lever{
            
            self.ViewFilter.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 393, height: 180))
            tableView.reloadData()
            FindButOutlet.isHidden = false
            self.LableFilter1.isHidden = false
            self.FilterLable2.isHidden = false
            buttonFishType.isHidden = false
            buttonWaterType.isHidden = false
            lever = false
            
        }else{
            self.ViewFilter.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 393, height: 0))
            tableView.reloadData()
            FindButOutlet.isHidden = true
            buttonFishType.isHidden = true
            buttonWaterType.isHidden = true
            self.LableFilter1.isHidden = true
            self.FilterLable2.isHidden = true
            
            lever = true
        }
        
    }
    //MARK: - Filter Button and Lable
    
    private func setFilerButton(){
        self.ViewFilter.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 393, height: 0))
        myButton(name: "Не выбрано", button: buttonFishType, viewLock: ViewButton1, tag: 1)
        myButton(name: "Не выбрано", button: buttonWaterType, viewLock: ViewButton2, tag: 2)
        FindButOutlet.isHidden = true
        buttonFishType.isHidden = true
        buttonWaterType.isHidden = true
        self.LableFilter1.isHidden = true
        self.FilterLable2.isHidden = true
    }

    
    @IBOutlet var LableFilter1: UILabel!
    
    @IBOutlet var FilterLable2: UILabel!
    
    @IBOutlet var ViewFilter: UIView!
    
    var buttonFishType = UIButton(frame: CGRect(x: 40, y: 20, width: 160, height: 50))
    var buttonWaterType = UIButton(frame: CGRect(x: 40, y: 50, width: 160, height: 50))
    
    @IBOutlet var ViewButton2: UIView!
    @IBOutlet var ViewButton1: UIView!
    

    @IBOutlet var FindButOutlet: UIButton!
    
    @IBAction func FindButAction(_ sender: Any) {
        fishStorage.filterFishAll(typeFish: typeFish, typeWater: typeWater)
        
        if typeFish != nil || typeWater != nil{
            isFiltSearch = true
            tableView.reloadData()
        }else {
            isFiltSearch = false
            tableView.reloadData()
        }

    }
    
    var isClick = true
    
    func myButton(name: String, button: UIButton, viewLock: UIView, tag: Int){

       
        button.tag = tag
        view.addSubview(button)
        button.setTitleColor(.systemBlue, for: .normal)
        button.center = viewLock.center
        button.setTitle(name, for: .normal)
        
       
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        


    }
    @objc func tapButton(sender: UIButton){

            if isClick{
                
                sender.setTitle(pop(sender: sender), for: .normal)
                isClick = false
                
            }else{
                sender.setTitle(pop(sender: sender), for: .normal)
                isClick = true
            
        }
        
        
    }
    var isFiltSearch = false
    var typeFish: TypeOfFish? = nil
    var typeWater: TypeWater? = nil
    func pop(sender: UIButton)-> String?{
        if sender.tag == 1{
            switch sender.titleLabel?.text{
            case "Не выбрано":
                typeFish = .predatorFish
                return "Хищная"
                
            case "Хищная":
                typeFish = .notPredatorFish
                return "Не хищная"
                
            case "Не хищная":
                typeFish = .exoticFish
                return "Экзотичная"
                
            case "Экзотичная":
                typeFish = nil
                return "Не выбрано"
            case .none:
                break
            case .some(_):
                break
                
            }
            
        }
        if sender.tag == 2{
            switch sender.titleLabel?.text{
            case "Не выбрано":
                typeWater = .water
                return "Речная"
                
            case "Речная":
                typeWater = .soilWater
                return "Морская"
                
            case "Морская":
                typeWater = nil
                return "Не выбрано"
                
            case .none:
                break
            case .some(_):
                break
            }
        }
        
        
        return ""
    }




    
    
    
}

/*extension FishTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.ignoresSearchSuggestionsForSearchBarPlacementStacked = false
    }
 func addResultss(for searchController: UISearchController)
 {
     let searchBar = searchController.searchBar
     let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
     let searchText = searchBar.text!
     filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
     
 }
 func updateSearchResults(for searchController: UISearchController)
 {
     addResultss(for: searchController)
 }
 func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "all")
 {
     
     
     filterFish = allFishArray.filter
     {
         shape in
         
         let scopeMatch = (scopeButton == "all" || (shape.typeFish.lowercased().contains(scopeButton.lowercased())))
         if searchController.searchBar.text != ""{
             let searchTextMatch = shape.typeFish.lowercased().contains(searchText.lowercased())
             
             return scopeMatch && searchTextMatch
         }else{
             return scopeMatch
         }
         
     }
     FishTable.reloadData()
 }
    
    
    

}*/
