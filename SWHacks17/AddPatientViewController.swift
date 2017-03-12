//
//  AddPatientViewController.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import CoreData
import MapKit
class AddPatientViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextView!
    @IBOutlet weak var radiusfield: UITextField!
    
    let userDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePatient(_ sender: UIButton) {
//        let ent = NSEntityDescription.entity(forEntityName: "User", in: self.userDataContext)
//        let newItem = User(entity: ent!, insertInto: self.userDataContext)
//        newItem.name = nameField.text
//        newItem.radius = Int16(radiusfield.text!)!
//        newItem.address = addressField.text
        getCoordinates()
        
//        print(newItem.name!)
//        print(newItem.lat)
//        print(newItem.long)
        
        
        
    }
    func textFieldShouldReturn(textField:UITextField)->Bool {
        nameField.resignFirstResponder()
        radiusfield.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //self.nameField.resignFirstResponder()
        self.nameField.resignFirstResponder()
        self.radiusfield.resignFirstResponder()
        
    }
    
    func getCoordinates()
    {
        let ent = NSEntityDescription.entity(forEntityName: "User", in: self.userDataContext)
        let newItem = User(entity: ent!, insertInto: self.userDataContext)
        
        newItem.name = nameField.text
        newItem.radius = Int16(radiusfield.text!)!
        newItem.address = addressField.text
        
        let address = addressField.text!
        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
//            let placemark = placemarks?[0]
//            newItem.lat = Float(placemark!.location!.coordinate.latitude)
//            newItem.long = Float(placemark!.location!.coordinate.longitude)
//        } as! CLGeocodeCompletionHandler)
//    }
        geocoder.geocodeAddressString(address) { placemarks, error in

                    let placemark = placemarks?[0]
                    var lat1 = Float(placemark!.location!.coordinate.latitude)
                    var long1 = Float(placemark!.location!.coordinate.longitude)
            newItem.lat = lat1
            newItem.long = long1
            print(newItem.lat)
            print(newItem.long)
    }
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
