//
//  CaregiverViewController.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import CoreData

class CaregiverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var caregiverTable: UITableView!
    
    let CaregiverDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var fetchResults = [Caregiver]()
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        var x   = 0
        // Execute the fetch request, and cast the results to an array of LogItem objects
        fetchResults = ((try? CaregiverDataContext.fetch(fetchRequest)) as? [Caregiver])!
        
        
        x = fetchResults.count
        
        print(x)
        
        
        return x
        
        
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadTable(_ sender: AnyObject) {
        
        caregiverTable.reloadData()
    }
    
    //number of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    //layout of cell
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "caregiverCell", for: indexPath) as!caregiverTableViewCell
        cell.layer.borderWidth = 0.2
        cell.caregiverName.text = fetchResults[indexPath.row].name
        cell.caregiverPhone.text = fetchResults[indexPath.row].phoneNumber
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Caregiver")
        
        
        if  let fetchResults = (try? CaregiverDataContext.fetch(fetchRequest)) as? [Caregiver]
        {
            
            let x = fetchResults.count
            
            
            print(x)
            if x != 0 {
                let l = fetchResults[indexPath.row]
                let picture = UIImage(data: l.photo!  as Data)
                cell.caregiverImage.image = picture
                
            }
            
        }
        
        
        return cell
    }


    //SEGUES
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
