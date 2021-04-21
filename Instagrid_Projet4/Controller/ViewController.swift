//
//  ViewController.swift
//  Instagrid_Projet4
//
//  Created by Antoinette Diana on 20/04/2021.
//

import UIKit

class ViewController: UIViewController {

    // Layout Button declaration
    @IBOutlet var layout1Button : UIButton!
    @IBOutlet var layout2Button : UIButton!
    @IBOutlet var layout3Button : UIButton!
    
//    Photo Button declaration
    @IBOutlet var photo1Button : UIButton!
    @IBOutlet var photo2Button : UIButton!
    @IBOutlet var photo3Button : UIButton!
    @IBOutlet var photo4Button : UIButton!
    
//    Photo Stack View declaration
    @IBOutlet var photoView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayoutStacking(withLayoutButton: layout2Button)
        updatePhotoStacking(withLayoutButton: layout2Button)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeGestureUp.direction = UISwipeGestureRecognizer.Direction.up
        photoView.addGestureRecognizer(swipeGestureUp)
    }


    
    @IBAction func tapLayout1Button(_ sender: UIButton) {
        updateLayoutStacking(withLayoutButton: layout1Button)
        updatePhotoStacking(withLayoutButton: layout1Button)
    }
    
    @IBAction func tapLayout2Button(_ sender: UIButton) {
        updateLayoutStacking(withLayoutButton: layout2Button)
        updatePhotoStacking(withLayoutButton: layout2Button)
    }
    
    @IBAction func tapLayout3Button(_ sender: UIButton) {
        updateLayoutStacking(withLayoutButton: layout3Button)
        updatePhotoStacking(withLayoutButton: layout3Button)
    }
    
    @IBAction func respondToSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.up :
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { [self] in
                photoView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
            }, completion:{(success) in
                if success {
                    self.photoView.transform = .identity
                    self.shareImage()
                }
            } )
        default:break
        }
    }
    
    private func shareImage() {
        let photoBounds = photoView.bounds
        UIGraphicsBeginImageContextWithOptions(photoBounds.size,true,0.0)
        self.photoView.drawHierarchy(in: photoBounds, afterScreenUpdates: true)
            let photoImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        let imageToShare = [photoImage!]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true,completion: nil)
    }
    
    private func updateLayoutStacking(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layout1Button :
            layout1Button.isSelected = true
            layout2Button.isSelected = false
            layout3Button.isSelected = false
        case layout2Button :
            layout1Button.isSelected = false
            layout2Button.isSelected = true
            layout3Button.isSelected = false
        case layout3Button :
            layout1Button.isSelected = false
            layout2Button.isSelected = false
            layout3Button.isSelected = true
        default: break
        }
    }
    
    private func updatePhotoStacking(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layout1Button :
            photo2Button.isHidden = true
            photo4Button.isHidden = false
        case layout2Button :
            photo2Button.isHidden = false
            photo4Button.isHidden = true
        case layout3Button :
            photo2Button.isHidden = false
            photo4Button.isHidden = false
        default: break
        }
    }
}

