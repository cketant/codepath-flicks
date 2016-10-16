//
//  ViewController.swift
//  Flicks
//
//  Created by christopher ketant on 10/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let apiKey = "c4c0e2efc0699536ed4d62b6ca6e67a4"
    let refreshControl: UIRefreshControl! = UIRefreshControl()
    var moviesArray: Array<NSDictionary>! = []
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.addTarget(self, action: #selector(loadMovies), for: UIControlEvents.valueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.tableView.insertSubview(self.refreshControl, at: 0)
        self.loadMovies()
    }
    
    func loadMovies(){
        
        let url: URL! = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(self.apiKey)")
        let request = URLRequest(url: url)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
            self.errorLbl.isHidden = true
        }
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    self.moviesArray = responseDictionary.value(forKey: "results") as? Array<NSDictionary>
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.reloadData()
                    }
                }
            }else{
                UIView.animate(withDuration: 0.3, delay: 3.0, options: .transitionCurlDown, animations: {
                    self.errorLbl.isHidden = false
                    }, completion: { (true) in
                        NSLog("Finished")
                })
                MBProgressHUD.hide(for: self.view, animated: true)

            }
        })
        task.resume()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movie-cell", for: indexPath) as! MovieTableViewCell
        let movie: NSDictionary = self.moviesArray[indexPath.row]
        let path: String = movie.value(forKey: "poster_path") as! String
        let url: URL! = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        cell.movieImgView.setImageWith(url)
        cell.movieTitleLbl.text = movie.value(forKey: "title") as? String
        cell.movieDescLbl.text = movie.value(forKey: "overview") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: MovieDetailViewController = segue.destination as! MovieDetailViewController
        let indexPath: IndexPath! = self.tableView.indexPath(for: (sender as! UITableViewCell))
        let movieDict: NSDictionary = self.moviesArray[indexPath.row]
        vc.movieDict = movieDict
    }

}
