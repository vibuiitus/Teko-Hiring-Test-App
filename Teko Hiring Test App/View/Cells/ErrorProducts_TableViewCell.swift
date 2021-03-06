//
//  ErrorProducts_TableViewCell.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit

//
// MARK: - Error Products Cell
//
class ErrorProductsTableViewCell: UITableViewCell {
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var SKULabel: UILabel!
    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var NameErrorLabel: UILabel!
    @IBOutlet weak var SKUErrorLabel: UILabel!
    
    //
    // MARK: - Table View Cell
    //
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }

}
