//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by christopher ketant on 10/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet var movieImgView: UIImageView!
    @IBOutlet weak var movieDescLbl: UILabel!
    @IBOutlet weak var ratingsLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var movieTitleLbl: UILabel!
    var movieDict: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path: String = movieDict.value(forKey: "poster_path") as! String
        let url: URL! = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        self.movieImgView.setImageWith(url)
        self.movieTitleLbl.text = self.movieDict.value(forKey: "title") as? String
        self.movieDescLbl.text = self.movieDict.value(forKey: "overview") as? String
        let ratings: Float = self.movieDict.value(forKey: "vote_average") as! Float
        self.ratingsLbl.text = "\(ratings)"
        self.dateLbl.text = self.movieDict.value(forKey: "release_date") as? String
    }

}
