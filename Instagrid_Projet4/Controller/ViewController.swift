//
//  ViewController.swift
//  Instagrid_Projet4
//
//  Created by Antoinette Diana on 20/04/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlet
    // Layout Button declaration
    @IBOutlet var layout1Button : UIButton!
    @IBOutlet var layout2Button : UIButton!
    @IBOutlet var layout3Button : UIButton!
    
    // Photo Button declaration
    @IBOutlet var photo1Button : UIButton!
    @IBOutlet var photo2Button : UIButton!
    @IBOutlet var photo3Button : UIButton!
    @IBOutlet var photo4Button : UIButton!
    
    // Photo Stack View declaration
    @IBOutlet var photoView : UIView!
    
    // MARK: - Action Outlet
    // Layout Button action
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
    
    // photo Button action
    @IBAction func photo1ButtonTap(_ sender: UIButton) {
        tapButtonAction(sender: sender)
    }
    @IBAction func photo2ButtonTap(_ sender: UIButton) {
        tapButtonAction(sender: sender)
    }
    @IBAction func photo3ButtonTap(_ sender: UIButton) {
        tapButtonAction(sender: sender)
    }
    @IBAction func photo4ButtonTap(_ sender: UIButton) {
        tapButtonAction(sender: sender)
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayoutStacking(withLayoutButton: layout2Button)
        updatePhotoStacking(withLayoutButton: layout2Button)
        
//        let orientation = UIDevice.current.orientation
//        switch orientation {
//        case UIDeviceOrientation.landscapeLeft, UIDeviceOrientation.landscapeRight:
//            let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureLeft))
//            swipeGestureLeft.direction = UISwipeGestureRecognizer.Direction.left
//            self.photoView.addGestureRecognizer(swipeGestureLeft)
//        case UIDeviceOrientation.portrait :
//            let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureUp))
//            swipeGestureUp.direction = UISwipeGestureRecognizer.Direction.up
//            self.photoView.addGestureRecognizer(swipeGestureUp)
//        default:break
//        }
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureUp))
        swipeGestureUp.direction = UISwipeGestureRecognizer.Direction.up
        photoView.addGestureRecognizer(swipeGestureUp)

        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureLeft))
        swipeGestureLeft.direction = UISwipeGestureRecognizer.Direction.left
        photoView.addGestureRecognizer(swipeGestureLeft)
    }
    
    // MARK: - Methodes
    /// select the layout button choosen and unselected the other one
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
    /// select the photo format following the layout choosen
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
    
    /// action to perform after swipe gesture
    @objc func respondToSwipeGestureUp () {
        let transform : CGAffineTransform
        transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { [self] in
            photoView.transform = transform
        }, completion:{_ in
            self.photoView.transform = .identity
            self.shareImage()
        } )
    }
    
    @objc func respondToSwipeGestureLeft () {
        let transform : CGAffineTransform
        transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { [self] in
            photoView.transform = transform
        }, completion:{_ in
            self.photoView.transform = .identity
            self.shareImage()
        } )
    }
    
    /// create an UIImage from a UIView
    private func imageWithView(view:UIView) -> UIImage {
        let viewBounds = view.bounds
        UIGraphicsBeginImageContextWithOptions(viewBounds.size,false,0.0)
        view.drawHierarchy(in: viewBounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /// open the UIActivityViewController to share a UIImage
    private func shareImage() {
        let imageToShare = [imageWithView(view: photoView)]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true,completion: nil)
    }
    
    /// open the library to choose a picture when tapping on a photo button
    private func tapButtonAction(sender:UIButton) {
        selectionButton(button: sender)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    /// select the photo button choosen and unselected the other one
    private func selectionButton(button: UIButton) {
        switch button {
        case photo1Button:
            photo1Button.isSelected = true
            photo2Button.isSelected = false
            photo3Button.isSelected = false
            photo4Button.isSelected = false
        case photo2Button:
            photo1Button.isSelected = false
            photo2Button.isSelected = true
            photo3Button.isSelected = false
            photo4Button.isSelected = false
        case photo3Button:
            photo1Button.isSelected = false
            photo2Button.isSelected = false
            photo3Button.isSelected = true
            photo4Button.isSelected = false
        case photo4Button:
            photo1Button.isSelected = false
            photo2Button.isSelected = false
            photo3Button.isSelected = false
            photo4Button.isSelected = true
        default:break
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        if photo1Button.isSelected {
            photo1Button.setImage(image, for: .normal)
        } else if photo2Button.isSelected {
            photo2Button.setImage(image, for: .normal)
        } else if photo3Button.isSelected {
            photo3Button.setImage(image, for: .normal)
        } else if photo4Button.isSelected {
            photo4Button.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


