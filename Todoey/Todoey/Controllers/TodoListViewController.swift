//
//  ViewController.swift
//  Todoey
//
//  Created by Dona Ganzorig on 8/25/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    // called before NavigationController ready
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = .none
    }
    
    // called after NavigationController ready
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist") }
        guard let colorHex = selectedCategory?.backgroundColor else { fatalError() }
        self.title = selectedCategory?.name
        updateNavBar(withHexCode: colorHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateNavBar(withHexCode: "1D9BF6")
    }
    
    //MARK - Nav Bar Setup Code Methods
    func updateNavBar(withHexCode colorHexCode: String) {
        guard let navBar = navigationController?.navigationBar else { fatalError() }
        guard let navBarColor = HexColor(colorHexCode) else { fatalError() }
        let contrastColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.barTintColor = navBarColor
        navBar.tintColor = contrastColor
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastColor]
        searchBar.barTintColor = navBarColor
    }
    
    //MARK - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // same as if we made an IB outlet and called it 'tableView'
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            if let color = HexColor(self.selectedCategory!.backgroundColor)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(self.todoItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            } else {
                cell.backgroundColor = FlatSkyBlue()
            }
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // flashes gray to white
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error updating item, \(error)")
            }
        }
        tableView.reloadData()
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when the user clicks 'add item'
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving item, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        self.todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        self.tableView.reloadData()
    }
    
    //MARK: - Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
    
}

//MARK - SearchBar methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadItems()
            // do in main thread
            DispatchQueue.main.async {
                searchBar.resignFirstResponder() // should no longer be the thing that is selected
            }
        }
    }

}

