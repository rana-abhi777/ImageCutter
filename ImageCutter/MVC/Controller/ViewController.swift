//
//  ViewController.swift
//  ImageCutter
//
//  Created by Sierra 4 on 16/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageUploaded = UIImage()
    var imageSplitArray = [UIImage]()
    
    var widthImageUploaded: CGFloat?
    var heightImageUploaded: CGFloat?
    
    let rowsSuper = 3
    let columnsSuper = 3
    
    var startClock = Timer()
    var timer = 5
    
    @IBOutlet var imgLowerViewCollection: [UIImageView]!
    @IBOutlet weak var lblTimeLeftTitle: UILabel!
    @IBOutlet weak var lblTimeLeftValue: UILabel!
    @IBOutlet weak var viewImageView: UIImageView!
    
    func genericAlertMessage(theTitle: String, theMessage: String)
    {
        let alertController = UIAlertController(title: theTitle, message: theMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuView") as! MenuViewController
//            self.present(nextViewController, animated: true, completion: nil)
//            if let navController = self.navigationController {
//                navController.popViewController(animated: true)
//            }
            
        })
        //let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageUploaded = viewImageView.image!
        widthImageUploaded = imageUploaded.size.width
        heightImageUploaded = imageUploaded.size.height
        //startTimer()
        startClock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        //addDelay()
        
    }
    func startTimer() {
        startClock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
    }
    func countDown() {
        lblTimeLeftValue.text = "\(timer)s"
        if timer == 0 {
           startClock.invalidate()
           self.genericAlertMessage(theTitle: "Alert!!!", theMessage: "Your times up Bruh!!!\nRemember Big Bro is watching!!!\nNo Cheating.")
           
        }
        timer = timer - 1
        
    }
    func addDelay() {
        // adding a timer delay =====================================================
        let when = DispatchTime.now() + 10 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.genericAlertMessage(theTitle: "Alert!!!", theMessage: "Your times up Bruh!!!\nRemember Big Bro is watching!!!\nNo Cheating.")
        }
        // ==============================================================================
    }
    func splitImage(image: UIImage, heightOfImage: CGFloat, widthOfImage: CGFloat) {
        var xPos: CGFloat = 0.0
        var  yPos: CGFloat = 0.0
        
        let widthOfSplitImages = CGFloat(Float(widthOfImage) / Float(columnsSuper))
        let heightOfSplitImages = CGFloat(Float(heightOfImage) / Float(rowsSuper))
        
        for row in 0..<rowsSuper {
            yPos = yPos + CGFloat(Float(row) * Float(heightOfSplitImages))
            for col in 0..<columnsSuper {
                xPos = xPos + CGFloat(Float(col) * Float(widthOfSplitImages))
                let rect = CGRect(x: xPos, y: yPos, width: widthOfSplitImages, height: heightOfSplitImages)
                let imageRef: CGImage = (image.cgImage?.cropping(to: rect))!
                let image: UIImage = UIImage(cgImage: imageRef, scale: 1, orientation: image.imageOrientation)
                
                //saving the cropped image in an array
                imageSplitArray.append(image)
                xPos = 0.0
                yPos = 0.0
            }
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func btnSplitImage(_ sender: Any) {
        splitImage(image: imageUploaded, heightOfImage: heightImageUploaded!, widthOfImage: widthImageUploaded!)
        for index in 0...(imgLowerViewCollection.count - 1) {
            imgLowerViewCollection[index].image = imageSplitArray[index]
        }
    }
}

