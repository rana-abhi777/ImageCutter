//
//  ViewController.swift
//  ImageCutter
//
//  Created by Sierra 4 on 16/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // image uploaded varaible and the array for the split images
    var imageUploaded = UIImage()
    var imageSplitArray = [UIImage]()
    
    // calculate the image dimensions for the uploaded one
    var widthImageUploaded: CGFloat?
    var heightImageUploaded: CGFloat?
    
    // rows and cols for the splitting of the image
    let rowsSuper = 3
    let columnsSuper = 3
    
    // timer for the timer and the alert of ending the puzzle after the ending of the time
    var startClock = Timer()
    var timer = 5
    
    var translation = CGPoint()// translation point in the gesture applied in the image views
    
    
    
    @IBOutlet var imgUpperViewCollection: [UIImageView]!
    
    
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
    
    func getTheCenterOfUpperCollection(imgViewCollection: [UIImageView]) {
        for index in 0...(imgLowerViewCollection.count - 1){
            
            print("the position is x: \(imgLowerViewCollection[index].center.x) and y: \(imgLowerViewCollection[index].center.y)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(HandlePanAll(_:)))
//        self.view.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
        imageUploaded = viewImageView.image!
        widthImageUploaded = imageUploaded.size.width
        heightImageUploaded = imageUploaded.size.height
        //startTimer()
//        startClock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        //addDelay()
        print("The image collection lower coordinates are : ")
        for index in 0...(imgLowerViewCollection.count - 1){
            
            print("the position is x: \(imgLowerViewCollection[index].center.x) and y: \(imgLowerViewCollection[index].center.y)")
        }
        
        
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
    @IBAction func UpperHandlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Gesture started at x: \(gesture.view!.center.x) y: \(gesture.view!.center.y)")
        case .changed:
            translation = gesture.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gesture.view!.center = CGPoint(x: gesture.view!.center.x + translation.x, y: gesture.view!.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            print("Gesture eneded at x : \(gesture.view!.center.x) y: \(gesture.view!.center.y)")
        default:
            print("default case man!")
        }
    }
    
    
    // this below handle pan function is only for making dragging an image from lower image view collection to upper image view collection
    @IBAction func HandlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        var initialPoint = CGPoint()
        switch gestureRecognizer.state {
        case .began:
            print("Gesture started at x : \(gestureRecognizer.view!.center.x) y: \(gestureRecognizer.view!.center.y)")
            initialPoint.x = gestureRecognizer.view!.center.x
            initialPoint.y = gestureRecognizer.view!.center.y
        case .changed:
            translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x/* + translation.x*/, y: gestureRecognizer.view!.center.y/* + translation.y*/)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            print("Gesture eneded at x : \(gestureRecognizer.view!.center.x) y: \(gestureRecognizer.view!.center.y)")
            var pointEnded = CGPoint()
            pointEnded.x = gestureRecognizer.view!.center.x
            pointEnded.y = gestureRecognizer.view!.center.y
            var viewItersectedIndex = [Int]()
            var indexCenterDistanceDict = [Int: CGFloat]()
            for index in 0...(imgUpperViewCollection.count - 1) {
                // check intersection of 2 views
                if (imgUpperViewCollection[index].frame.intersects(gestureRecognizer.view!.frame)) {
                    print("collision detected with \(index) image view")
                    viewItersectedIndex.append((index + 1))
                    let centerOfIntersected = imgUpperViewCollection[index].center
                    let distanceFromCenter = distance(a: pointEnded, b: centerOfIntersected)
                    indexCenterDistanceDict[index] = distanceFromCenter
                    // this results is view which being moved to occupy the as much space as it's parent view.
                    //gestureRecognizer.view!.frame = imgUpperViewCollection[0].frame
                }
                else {
//                    if gestureRecognizer.state == UIGestureRecognizerState.ended {
//                        // 1
//                        let velocity = gestureRecognizer.velocity(in: self.view)
//                        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//                        let slideMultiplier = magnitude / 200
//                        print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
//                        
//                        // 2
//                        let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
//                        // 3
//                        var finalPoint = CGPoint(x:gestureRecognizer.view!.center.x + (velocity.x * slideFactor),
//                                                 y:gestureRecognizer.view!.center.y + (velocity.y * slideFactor))
//                        // 4
//                        finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
//                        finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
//                        
//                        // 5
//                        UIView.animate(withDuration: Double(slideFactor * 2),
//                                                   delay: 0,
//                                                   // 6
//                                        options: UIViewAnimationOptions.curveEaseOut,
//                                        animations: {gestureRecognizer.view!.center = finalPoint },
//                                        completion: nil)
//                    }
                }
                
            }
            
            let indexSelected = shortestDistance(distanceDictionary: indexCenterDistanceDict)
            gestureRecognizer.view!.frame = imgUpperViewCollection[indexSelected].frame
            
//            for index in 0...(imgLowerViewCollection.count - 1) {
//                // check intersection of 2 views
//                if (imgLowerViewCollection[index].frame.intersects(gestureRecognizer.view!.frame)) {
//                    print("collision detected with \(index) image view")
//                    viewItersectedIndex.append((index + 1))
//                    let centerOfIntersected = imgLowerViewCollection[index].center
//                    let distanceFromCenter = distance(a: pointEnded, b: centerOfIntersected)
//                    indexCenterDistanceDict[index] = distanceFromCenter
//                    // this results is view which being moved to occupy the as much space as it's parent view.
//                    //gestureRecognizer.view!.frame = imgUpperViewCollection[0].frame
//                }
//            }
//            
//            let indexSelectedForLower = shortestDistance(distanceDictionary: indexCenterDistanceDict)
//            gestureRecognizer.view!.frame = imgLowerViewCollection[indexSelectedForLower].frame

        default:
            print("default executed")
        }
        
    }
    // calculate the shortest distance between the intersecting views 
    // and returning the index of the shortest distance view 
    func shortestDistance (distanceDictionary: [Int: CGFloat]) -> Int {
        var index = 20
        var min = CGFloat(100)
        for (key,value) in distanceDictionary {
            if value < min {
                min = value
                index = key
            }
        }
        return index
    }
    // calculate the distance between the centers of the 2 views one - the intersecting view and the center of position 
    // where pan gesture ended
    func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
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

