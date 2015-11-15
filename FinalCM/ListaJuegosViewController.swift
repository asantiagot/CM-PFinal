//
//  ListaJuegosViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 11/13/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//
import UIKit


class ListaJuegosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: ATTRIBUTES
    
    let cellReuseIdentifier = "MyCellReuseIdentifier"
    
    var parser = ListaXMLParser()
    
    // MARK: METHODS
    
    override func viewDidLoad() {
        if parser.verifyValues() {
            print("Connection successful")
        } else {
            let noConnectionController = UIAlertController(title: "Conexión no establecida", message: "El servidor no está disponible o no tienes acceso a internet. Intenta más tarde.", preferredStyle: UIAlertControllerStyle.Alert)
            noConnectionController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(noConnectionController, animated: true, completion: nil)
        }
    }
    
    // MARK: TABLEVIEWDATASOURCE METHODS

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier)! as UITableViewCell
        
        cell.textLabel?.text = parser.posts[indexPath.row]["NAME"]
        cell.detailTextLabel?.text = parser.posts[indexPath.row]["DESCRIPTION"]
        return cell
    }

    // MARK: TABLEVIEWDELEGATE METHODS
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

