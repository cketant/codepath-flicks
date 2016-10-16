//
//  MovieTableViewCell.swift
//  Flicks
//
//  Created by christopher ketant on 10/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImgView: UIImageView!
    @IBOutlet var movieTitleLbl: UILabel!
    @IBOutlet var movieDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
