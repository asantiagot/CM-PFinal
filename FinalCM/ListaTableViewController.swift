//
//  ListaTableViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 11/14/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController {
    
    // MARK: ATTRIBUTES

    let xmlParser = ListaXMLParser()

    // MARK: METHODS

    override func viewDidLoad() {
        
        self.title = "👾 Lista de Juegos 👾"
        
        super.viewDidLoad()
        
        if xmlParser.verifyValues() {
            print("Connection successful")
        } else {
            let noConnectionController = UIAlertController(title: "Conexión no establecida", message: "El servidor no está disponible o no tienes acceso a internet. Intenta más tarde.", preferredStyle: UIAlertControllerStyle.Alert)
            noConnectionController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(noConnectionController, animated: true, completion: nil)
        }
    }


    // MARK: - Table view data source
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlParser.posts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "JuegoTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! JuegoTableViewCell

        let posts = xmlParser.posts[indexPath.row]
        let urlString = posts["URL"]
        
        cell.title.text = posts["NAME"]
        cell.about.text = posts["DESCRIPTION"]
        cell.thumbnail.image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlString!)!)!)
        cell.thumbnail.contentMode = UIViewContentMode.ScaleAspectFit
        return cell
    }
    
    // MARK: TableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
