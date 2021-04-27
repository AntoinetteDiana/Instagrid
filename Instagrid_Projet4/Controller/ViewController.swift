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
    @IBOutlet var layoutButton: [UIButton]!
    
    // Photo Button declaration
    @IBOutlet var photoButton: [UIButton]!
    
    // Photo Stack View declaration
    @IBOutlet var photoView : UIView!
    
    // MARK: - Action Outlet
    
    // Layout Button action
    @IBAction func layoutButtonTap(_ sender: UIButton) {
        updateLayoutStacking(withLayoutButton: sender)
        updatePhotoStacking(withLayoutButton: sender)
    }
    
    // photo Button action
    @IBAction func photoButtonTap(_ sender: UIButton) {
        tapButtonAction(sender: sender)
    }
    
    // MARK: - Properties
    
    private var swipeGesture : UISwipeGestureRecognizer?
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLayoutStacking(withLayoutButton: layoutButton[1])
        updatePhotoStacking(withLayoutButton: layoutButton[1])
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        photoView.addGestureRecognizer(swipeGesture!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(wichSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Methodes
    @objc private func wichSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGesture?.direction = .left

        } else {
            swipeGesture?.direction = .up
        }
    }
    
    /// select the layout button choosen and unselected the other one
    private func updateLayoutStacking(withLayoutButton : UIButton) {
        for button in layoutButton {
            button.isSelected = false
        }
        withLayoutButton.isSelected = true
    }
    
    /// select the photo format following the layout choosen
    private func updatePhotoStacking(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layoutButton[0] :
            photoButton[1].isHidden = true
            photoButton[3].isHidden = false
        case layoutButton[1] :
            photoButton[1].isHidden = false
            photoButton[3].isHidden = true
        case layoutButton[2] :
            photoButton[1].isHidden = false
            photoButton[3].isHidden = false
        default: break
        }
    }
    
    /// open the library to choose a picture when tapping on a photo button
    private func tapButtonAction(sender:UIButton) {
        selectionButton(button: sender)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    /// select the photo button choosen and unselected the other one
    private func selectionButton(button: UIButton) {
        for photo in photoButton {
            photo.isSelected = false
        }
        button.isSelected = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        for photo in photoButton {
            if photo.isSelected {
                photo.setImage(image, for: .normal)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// action to perform after swipe gesture
    @objc func respondToSwipeGesture () {
        let transform : CGAffineTransform
        transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)

        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { [self] in
            photoView.transform = transform
        }, completion:{_ in
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
        self.present(activityViewController, animated: true,completion:{
            self.photoView.transform = .identity
        })
    }
    
}


