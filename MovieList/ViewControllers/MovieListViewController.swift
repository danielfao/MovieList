//
//  HomeViewController.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: MovieListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        }
    }
    
    // MARK: - Variables
    private var movies: [Movie] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar
        self.navigationItem.title = String.localize("navigation_movie_list_title")
        
        MovieListService.getMovieList { (movies) in
            self.movies = movies
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self), for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(movies: self.movies[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movies = self.movies[indexPath.row]
        movies.downloadPosterImage { (image) in
            guard let cell = self.tableView.cellForRow(at: indexPath) as? MovieListTableViewCell else {
                return
            }
            cell.setupCell(movies: movies)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            let movie = self.movies[indexPath.row]
            guard let viewController = UIStoryboard(name: .MovieDetail).instantiateViewController(withIdentifier: ViewControllerName.MovieDetailView) as? MovieDetailViewController else {
                return
            }
            viewController.movie = movie
            self.navigationController?.pushViewController(viewController, animated: true)
    }
}
