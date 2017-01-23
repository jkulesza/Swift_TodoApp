//
//  FirstViewController.swift
//  Swift_TodoApp
//
//  Created by Joel A. Kulesza on 12/30/16.
//  Copyright © 2016 Joel A. Kulesza. All rights reserved.
//

import UIKit

struct item {
  var title = ""
  var urgency = 0
}

var data: [item] = []

var searchActive = false

var filtered:[item] = data

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(searchActive) {
      return filtered.count
    }
    return data.count;
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
    if(searchActive){
      cell.textLabel?.text = filtered[indexPath.row].title
      cell.detailTextLabel?.text = "Urgency: " + String(filtered[indexPath.row].urgency)
    } else {
      cell.textLabel?.text = data[indexPath.row].title
      cell.detailTextLabel?.text = "Urgency: " + String(data[indexPath.row].urgency)

    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if(editingStyle == UITableViewCellEditingStyle.delete) {
      if(searchActive){
        filtered.remove(at: indexPath.row)
        data.remove(at: indexPath.row)
      } else {
        data.remove(at: indexPath.row)
      }
      tableView.reloadData()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.reloadData()
    data.sort { $0.urgency > $1.urgency }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
    searchActive = true;
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchActive = false;
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.showsCancelButton = false
    searchActive = false;
    searchBar.endEditing(true)
    self.tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false;
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if(searchBar.text == nil || searchBar.text == "") {
      searchActive = false
    } else {
      
      filtered = data.filter({ (text) -> Bool in
        return(text.title.range(of: searchText, options: .caseInsensitive) != nil)
      })
      
      if(filtered.count == 0){
        searchActive = false;
      } else {
        searchActive = true;
      }
      
    }
    self.tableView.reloadData()
      
  }
 
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

