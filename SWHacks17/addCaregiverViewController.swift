//
//  addCaregiverViewController.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import CoreData

class addCaregiverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var imageSource: UISegmentedControl!
    let picker = UIImagePickerController()
    
    let caregiverDataContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCaregiver(_ sender: UIBarButtonItem) {
        let ent = NSEntityDescription.entity(forEntityName: "Caregiver", in: self.caregiverDataContext)
        let newItem = Caregiver(entity: ent!, insertInto: self.caregiverDataContext)
        
        newItem.name = nameField.text
        newItem.phoneNumber = phoneField.text
        
        let imageData = UIImagePNGRepresentation(self.profilePic.image!)
        newItem.photo = imageData as NSData?
        do {
            try self.caregiverDataContext.save()
        } catch _ {
        }
                
    }

    @IBAction func addPhoto(_ sender: UIButton) {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
        
        

    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        profilePic.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField:UITextField)->Bool {
        nameField.resignFirstResponder()
        phoneField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //self.nameField.resignFirstResponder()
        self.nameField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
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
