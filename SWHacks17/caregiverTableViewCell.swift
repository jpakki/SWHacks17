//
//  caregiverTableViewCell.swift
//  SWHacks17
//
//  Created by Jaswant Pakki on 3/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class caregiverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var caregiverImage: UIImageView!
    @IBOutlet weak var caregiverName: UILabel!
    @IBOutlet weak var caregiverPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //configure the view for the selected state
    }

}
