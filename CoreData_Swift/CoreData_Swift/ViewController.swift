//
//  ViewController.swift
//  CoreData-Swift
//
//  Created by 韩承海 on 2017/11/21.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import CoreData

/*
 Context 是非线程安全的 支持sqlite xml 二进制 和 内存存储 四种
 */


func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    var peoples = [NSManagedObject]()
    public var managedContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "name List"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetfhPeople();
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "New name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (_) in
            let textField = alert.textFields?.first
            self.addPeople(name: (textField?.text)!)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction.init(title: "Cencel", style: .cancel) { (action) in
            
        }
        alert.addTextField { (textfield) in
            
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func addPeople(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "People", in: managedContext)
        let people = NSManagedObject.init(entity: entity!, insertInto: managedContext)
        people.setValue(name, forKey: "name")
        do {
            try managedContext.save()
            peoples.append(people)
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    func fetfhPeople() {
        let fetchRequest: NSFetchRequest<People> = People.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "xiaohei");
        do {
            let results = try getContext().fetch(fetchRequest)
            print("num of results = \(results.count)")
            peoples = results as [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func goBowtieVc(_ sender: Any) {
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        cell.textLabel?.text = names[indexPath.row]
        let people = peoples[indexPath.row]
        cell.textLabel?.text = people.value(forKey: "name") as? String
        return cell
    }
}



