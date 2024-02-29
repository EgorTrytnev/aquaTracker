//
//  FishList.swift
//  GlassFish
//
//  Created by user on 29.11.2023.
//

import UIKit
import CoreData

class FishList: UITableViewController {

    var nameFishArr:[FishStor] = []
    var arrFish: [FishAquaProtocol] = []
    var fishStor = StrorageAqua()
    var numInAqua: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        
        fishStor.loadFishLibrary()
        loadFish()
        
        
        for i in nameFishArr{
            for fish in fishStor.allFishArray{
                if i.fishName! == fish.nameFish{
                    arrFish.append(fish)
                }
            }
        }
        
        print(arrFish)
        
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrFish.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiahListCell", for: indexPath) as! ListCell
        // получаем данные о задаче, которую необходимо вывести в ячейке
        
        let currentCell: FishAquaProtocol!
            
        currentCell = arrFish[indexPath.row]



        
        
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
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionScreen = storyboard.instantiateViewController(withIdentifier: "DesViewContr") as! DescriptionViewController
       
        let currentCell: FishAquaProtocol!

        currentCell = arrFish[indexPath.row]
        
            
        
        descriptionScreen.storageDes = currentCell
        descriptionScreen.numInAqua = numInAqua
        
        
        
        navigationController?.pushViewController(descriptionScreen, animated: true)
        
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
