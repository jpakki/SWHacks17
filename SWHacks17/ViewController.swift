//
//  ViewController.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import FontAwesome_swift
class ViewController: UIViewController {
    
    
    @IBOutlet weak var careGiverIcon: UILabel!
    @IBOutlet weak var geofenceIcon: UILabel!
    @IBOutlet weak var careGiversButton: UIButton!
    @IBOutlet weak var geofenceButton: UIButton!
    @IBOutlet weak var patientInfoIcon: UILabel!
    
    
    
    @IBOutlet weak var patientinfoButton: UIButton!
    
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "ughpls")
            self.view.insertSubview(backgroundImage, at: 0)
            

        
        careGiversButton.layer.cornerRadius = 30
        careGiversButton.layer.borderWidth = 2
        careGiversButton.layer.borderColor = UIColor.black.cgColor
        geofenceButton.layer.cornerRadius = 30
        geofenceButton.layer.borderWidth = 2
        geofenceButton.layer.borderColor = UIColor.black.cgColor
        patientinfoButton.layer.cornerRadius = 30
        patientinfoButton.layer.borderWidth = 2
        patientinfoButton.layer.borderColor = UIColor.black.cgColor
        
        careGiverIcon.font = UIFont.fontAwesome(ofSize: 30)
        careGiverIcon.text = String.fontAwesomeIcon(code: "fa-user-md")
        geofenceIcon.font = UIFont.fontAwesome(ofSize: 30)
        geofenceIcon.text = String.fontAwesomeIcon(code: "fa-map-pin")
        patientInfoIcon.font = UIFont.fontAwesome(ofSize: 30)
        patientInfoIcon.text = String.fontAwesomeIcon(code: "fa-user")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func returnedToMain(segue: UIStoryboardSegue) {
        
}
    

    

}
