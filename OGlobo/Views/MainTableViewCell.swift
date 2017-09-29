//
//  MainTableViewCell.swift
//  OGlobo
//
//  Created by Neto Moura on 26/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewNoticia: UIImageView!
    @IBOutlet weak var labelNomeSecao: UILabel!
    @IBOutlet weak var labelTituloNoticia: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
