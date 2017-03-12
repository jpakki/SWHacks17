//
//  ViewController.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var careGiversButton: UIButton!
    @IBOutlet weak var geofenceButton: UIButton!
    @IBOutlet weak var patientinfoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "ughpls")
            self.view.insertSubview(backgroundImage, at: 0)
            

        
        careGiversButton.layer.cornerRadius = 20
        careGiversButton.layer.borderWidth = 1
        careGiversButton.layer.borderColor = UIColor.black.cgColor
        geofenceButton.layer.cornerRadius = 20
        geofenceButton.layer.borderWidth = 1
        geofenceButton.layer.borderColor = UIColor.black.cgColor
        patientinfoButton.layer.cornerRadius = 20
        patientinfoButton.layer.borderWidth = 1
        patientinfoButton.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func returnedToMain(segue: UIStoryboardSegue) {
        
}


}

