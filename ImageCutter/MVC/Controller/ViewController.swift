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
    
    var width = 0
    var height = 0
    var widthSmallView = 0
    var heightSmallView = 0
    
    var heightForEachSplit = 0
    var widthForEachSplit = 0
    
    var rows = 3
    var columns = 3
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewImageView: UIImageView!
    
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
        
        let image = cropToBounds(image: imageSet, width: Double(widthSmallView), height: Double(heightSmallView))
        imgView.contentMode = .scaleAspectFit
        imgView.image = image
    }
}

