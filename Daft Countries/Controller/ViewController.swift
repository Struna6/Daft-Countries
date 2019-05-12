//
//  ViewController.swift
//  Daft Countries
//
//  Created by Karol Struniawski on 09/05/2019.
//  Copyright © 2019 Karol Struniawski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countriesProvider : CountriesProviding = CountriesProvider()
    var countries = [Country]()
    var countriesSearched = [Country]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searching : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        searching = false
        getCountries()
    }

    func getCountries(){
        countriesProvider.fetchCountries { (result) in
            switch result{
            case .success(let countriesGet):
                self.countries = countriesGet
                self.countriesSearched = self.countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                let alertController = UIAlertController.init(title: "Error", message: "Cannot get data about countries, please open application again!", preferredStyle: .alert)
                self.present(alertController, animated: true)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            let target = segue.destination as! DetailsVC
            target.country = searching ? self.countriesSearched[tableView.indexPathForSelectedRow!.row] : self.countries[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? countriesSearched.count : countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")!
        cell.textLabel?.text = searching ? countriesSearched[indexPath.row].name : countries[indexPath.row].name
        return cell
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searching = true
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension ViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searching = false
//        tableView.reloadData()
//    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = true
        tableView.reloadData()
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count > 0{
            countriesSearched = countries.filter(){
                let data : NSString = $0.name.lowercased() as NSString
                let range = data.range(of: searchText.lowercased(), options: NSString.CompareOptions.anchored)
                return range.location != NSNotFound
            }
        }else{
            countriesSearched = countries
        }

        tableView.reloadData()
    }
}


