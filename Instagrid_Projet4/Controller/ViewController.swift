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
    
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayoutStacking(withLayoutButton: layout2Button)
        updatePhotoStacking(withLayoutButton: layout2Button)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeGestureUp.direction = UISwipeGestureRecognizer.Direction.up
        photoView.addGestureRecognizer(swipeGestureUp)
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
//        photo1Button.contentMode = .scaleAspectFit
        
        if photo1Button.isSelected {
            photo1Button.setBackgroundImage(image, for: .normal)
        } else if photo2Button.isSelected {
            photo2Button.setBackgroundImage(image, for: .normal)
        } else if photo3Button.isSelected {
            photo3Button.setBackgroundImage(image, for: .normal)
        } else if photo4Button.isSelected {
            photo4Button.setBackgroundImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


