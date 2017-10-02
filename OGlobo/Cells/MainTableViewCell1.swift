//
//  MainTableViewCell1.swift
//  OGlobo
//
//  Created by Neto Moura on 29/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import UIKit

class MainTableViewCell1: UITableViewCell {

    @IBOutlet weak var imageViewNoticia1: UIImageView!
    @IBOutlet weak var labelNomeSecao1: UILabel!
    @IBOutlet weak var labelTituloNoticia1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
