//
//  ViewController.swift
//  ImageCutter
//
//  Created by Sierra 4 on 16/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageSet: UIImage = UIImage(named: "background1")!
    var imageCroppedArray = [UIImage]()
    
    var width = 0
    var height = 0
    var widthSmallView = 0
    var heightSmallView = 0
    
    var heightForEachSplit = 0
    var widthForEachSplit = 0
    
    var rows = 3
    var columns = 3
    
    @IBOutlet var imgLowerViewCollection: [UIImageView]!
    
    
    
    @IBOutlet weak var imgView: UIImageView!
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
        width = Int(viewImageView.frame.size.width)
        height = Int(viewImageView.frame.size.height)
        print("the width is : \(width)")
        print("the height is : \(height)")
        //resetTheViewSize(viewName: splitView1, widthToSet: CGFloat(200), heightToSet: CGFloat(200))
        widthSmallView = Int(viewImageView.frame.size.width)
        heightSmallView = Int(viewImageView.frame.size.height)
        print("The width of smaller view is \(widthSmallView)")
        print("The height of smaller view is \(heightSmallView)")
        splitImagesDimensions()
        
        // patterns of collection array
//        setdifferentColorbackGroundsToCollection()
        
//        // adding a timer delay =====================================================
//        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            self.genericAlertMessage(theTitle: "Alert!!!", theMessage: "Your times up Bruh!!!\nRemember Big Bro is watching!!!\nNo Cheating.")
//        }
//        // ==============================================================================
        cropImagesAll()
        setdifferentColorbackGroundsToCollection()
        
        
    }
    // different background color setting to the collection array
    func setdifferentColorbackGroundsToCollection() {
//        let colorsArray = [UIColor.orange, UIColor.red, UIColor.black, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.green, UIColor.magenta]
        for index in 0...(imgLowerViewCollection.count - 1) {
            imgLowerViewCollection[index].contentMode = .scaleAspectFit
            imgLowerViewCollection[index].image = imageCroppedArray[index]
//            imgLowerViewCollection[index].backgroundColor = colorsArray[index]
        }
    }
    @IBAction func btnBackClick(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func resetTheViewSize(viewName: UIView, widthToSet: CGFloat, heightToSet: CGFloat) {
        viewName.frame.size.width = widthToSet
        viewName.frame.size.height = heightToSet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func splitImagesDimensions() {
        heightForEachSplit = height / rows
        widthForEachSplit = width / columns
        print("height for each is  : \(heightForEachSplit)")
        print("width for each is : \(widthForEachSplit)")
    }
//    func cropSinglePart() -> UIImage?{
//        var xPos:CGFloat = 0.0
//        var yPos:CGFloat = 0.0
//        let width: CGFloat = CGFloat(self.width)
//        let height: CGFloat = CGFloat(self.height)
//        
//        let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
//        guard let cgImage = cgImage else {
//            return nil
//        }
//        guard let newCgImage = cgImage.cropping(to: rect) else {
//            return nil
//        }
//        
//        
//        return
//    }
    func cropImageComplete() {
        
    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
//        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
//        let contextSize: CGSize = contextImage.size
        let posX: CGFloat = 0.0
        let posY: CGFloat = 0.0
//        var cgwidth: CGFloat = CGFloat(width)
//        var cgheight: CGFloat = CGFloat(height)
        // See what size is longer and create the center off of that
        
//        if contextSize.width > contextSize.height {
//            posX = ((contextSize.width - contextSize.height) / 2)
//            posY = 0
//            cgwidth = contextSize.height
//            cgheight = contextSize.height
//        } else {
//            posX = 0
//            posY = ((contextSize.height - contextSize.width) / 2)
//            cgwidth = contextSize.width
//            cgheight = contextSize.width
//        }
        let rect: CGRect = CGRect(x: posX, y: posY, width: CGFloat(300), height: CGFloat(300))
        // Create bitmap image from context using the rect
        let imageRef: CGImage = imageSet.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    func cropImagesAll() {
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 0.0
        let widthInner = CGFloat(width / 3)
        print(widthInner)
        let heightInner = CGFloat(height / 3)
        print(heightInner)
        // row variable is kept for debugging of the for loop
        for row in 0..<3 {
            // col variable is kept for debugging of the for loop
            for col in 0..<3 {
                
                let rect: CGRect = CGRect(x: xPos, y: yPos, width: CGFloat(widthInner), height: CGFloat(heightInner))
                // Create bitmap image from context using the rect
                let imageRef: CGImage = imageSet.cgImage!.cropping(to: rect)!
                
                // Create a new image based on the imageRef and rotate back to the original orientation
                let image: UIImage = UIImage(cgImage: imageRef, scale: 1, orientation: imageSet.imageOrientation)
                
                imageCroppedArray.append(image)
//                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
//                let imageRef: CGImage? = imageSet.cgImage?.cropping(to: rect)
//                let image: UIImage = UIImage(cgImage: imageRef, scale: imageSet.scale, orientation: imageSet.imageOrientation)
//                imageCroppedArray.append(image)
                xPos = xPos + widthInner
                
            }
            yPos = yPos + heightInner
        }
        print("Cropping done")
    }

    
//    func getImagesFrom(_ image: UIImage) -> [Any] {
//        var images = [Any]()
//        //var imageSize: CGSize = image.size
//        var xPos: CGFloat = 0.0
//        let yPos: CGFloat = 0.0
//        let width: CGFloat = CGFloat(self.width)
//        let height: CGFloat = CGFloat(self.height)
//        for y in 0..<columns {
//            xPos = 0.0
//            for x in 0..<rows {
//                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
//                let cImage: CGImage? = image.cgImage?.cropping(to: rect)
//                let dImage = UIImage(cgImage: cImage!)
//                let imageView = UIImageView(frame: CGRect(x: CGFloat(x * Int(width)), y: CGFloat(y * Int(height)), width: width, height: height))
//                imageView.image = dImage
//                imageView.layer.borderColor = UIColor.black.cgColor
//                imageView.layer.borderWidth = 1.0
//                images.append(image)
//            }
//        }
//       return images
//    }
    
    
//    func splitImage() {
//        let imagesSplitArray = getImagesFrom(imageSet)
//    }

    @IBAction func btnSplitImage(_ sender: Any) {
        
//        let image = cropToBounds(image: imageSet, width: Double(widthSmallView), height: Double(heightSmallView))
//        imgView.contentMode = .scaleAspectFit
//        imgView.image = image
    }
}

