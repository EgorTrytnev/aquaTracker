//
//  familysFishTableView.swift
//  GlassFish
//
//  Created by user on 22.09.2023.
//

import UIKit


import UIKit


class familysFishTableView: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var fishStorage = StrorageAqua()
    var searchController = UISearchController()
    var numInAqua: Int = 0

    var stringFamilysFish: [String] = ["Цихлиды", "Карповые","Пецилиевые",
                              "Харациновые","Атериновые","Помацентровые",
                              "Карпозубые","Лабиринтовые","Радужницы","Сомовые","Осетровые","Вьюновые","Иглобрюховые"]
    var FamilysFishArray: [FamilysFishEnum] = [.Cichlids, .Carp, .Poeciliaceae,
                            .Characinaceae, .Atherine, .Pomacentral,
                                               .carp_toothed, .Labyrinthine, .Rainbows, .Catfish, .Sturgeon, .Cobitidae, .Pufferfish]
    
    

    override func viewWillAppear(_ animated: Bool) {
        print("Это", numInAqua)
        
        initsearchController()
        fishStorage.loadFishLibrary()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CellForFamilysFish", bundle: nil), forCellReuseIdentifier: "familysFishName")
        self.tableView.register(UINib(nibName: "SearchInFamilyTable", bundle: nil), forCellReuseIdentifier: "SearchInFamily")

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
        
        if isSearch(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "DesViewContr") as! DescriptionViewController
           
            let currentCell: FishAquaProtocol!
            
                currentCell = fishStorage.filterFish[indexPath.row]

                
            
            descriptionScreen.storageDes = currentCell
            descriptionScreen.numInAqua = numInAqua
            
            
            
            navigationController?.pushViewController(descriptionScreen, animated: true)
            
            
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "inTableFish") as! FishTableViewController
            
            
            descriptionScreen.familyFish = FamilysFishArray[indexPath.row]
            descriptionScreen.numInAqua = numInAqua
            
            navigationController?.pushViewController(descriptionScreen, animated: true)
        }
    }

   

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch(){
            return fishStorage.filterFish.count
        }else{
            return stringFamilysFish.count
        }
    }
    //заполнение ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearch(){
            return getConfiguredTaskCell_stackFish(for: indexPath)
        }else{
            return getConfiguredTaskCell_stackFamilysFish(for: indexPath)
        }
    }
    
    private func getConfiguredTaskCell_stackFamilysFish(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "familysFishName", for: indexPath) as! CellForFamilysFish
        // получаем данные о задаче, которую необходимо вывести в ячейке
        
        let currentCell: String!
        
        currentCell = stringFamilysFish[indexPath.row]
        
        
        cell.TextCell.text! = currentCell!

        return cell
    }
    private func getConfiguredTaskCell_stackFish(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchInFamily", for: indexPath) as! SearchInFamilyTable
        // получаем данные о задаче, которую необходимо вывести в ячейке
        
        let currentCell: FishAquaProtocol!
       
            currentCell = fishStorage.filterFish[indexPath.row]

        
        // изменим символ в ячейке
        cell.TextCell?.text = currentCell.nameFish
        

        return cell
    }
    

                                         
    private func filterFishArray(text: String){
        fishStorage.filterFishFind(text: text, fishArr: fishStorage.allFishArray)
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
