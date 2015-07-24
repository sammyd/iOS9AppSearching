//
//  CreateShoppingListViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 24/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class CreateShoppingListViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var tableView: UITableView!
  
  var selectedProducts = Set<Product>()
  
  var dataStore : DataStore? {
    didSet {
      tableView?.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    configureTableView(tableView)
  }
}

extension CreateShoppingListViewController {
  private func configureTableView(tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 70
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
  }
}

extension CreateShoppingListViewController {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "completeShoppingListCreation",
      let shoppingList = createNewShoppingList() {
      dataStore?.addShoppingList(shoppingList)
    }
  }
  
  private func createNewShoppingList() -> ShoppingList? {
    guard let name = nameTextField?.text,
      let date = datePicker?.date where !name.isEmpty else {
        return nil
    }
    return ShoppingList(name: name, date: date, products: Array(selectedProducts))
  }
}


extension CreateShoppingListViewController : UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore?.products.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
    if let cell = cell as? SelectableProductTableViewCell,
      let product = dataStore?.products[indexPath.row] {
        cell.product = product
        cell.setSelected(selectedProducts.contains(product), animated: false)
    }
    return cell
  }
}

extension CreateShoppingListViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let product = dataStore?.products[indexPath.row] {
      selectedProducts.insert(product)
    }
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    if let product = dataStore?.products[indexPath.row] {
      selectedProducts.remove(product)
    }
  }
}
