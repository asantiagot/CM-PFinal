//
//  ScannerViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 10/27/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Escáner"
        
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.height))
        imageView.image = UIImage(named: "SPSC.png")
        self.view.insertSubview(imageView, atIndex: 0)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.frame = imageView.bounds
        imageView.addSubview(blurBackground)

    }

    @IBAction func openImageSource(sender: UIButton)
    {
        let alertSheet = UIAlertController(title: "Opciones de Escáner", message: "Selecciona la fuente de tu imagen a escanear", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertSheet.addAction(UIAlertAction(title: "Cámara", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            
        }))
        alertSheet.addAction(UIAlertAction(title: "Biblioteca de fotos", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertSheet, animated: true, completion: nil)
        
    }
    
    //MARK: ImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
