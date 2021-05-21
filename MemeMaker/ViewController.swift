//
//  ViewController.swift
//  MemeMaker
//
//  Created by Brian Foutty on 3/17/21.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IB Outlets
    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    // MARK: - Instance Properties
    // #26a
    let topChoices = [
        CaptionOption(emoji: "😱", caption: "OMG!!"),
        CaptionOption(emoji: "👀", caption: "Hey, look at this!"),
        CaptionOption(emoji: "💕", caption: "You know what I love…"),
        CaptionOption(emoji: "🤬", caption: "You know what makes me mad?"),
        CaptionOption(emoji: "😳", caption: "Holy crap!!💩")
    ]
    // #26b
    let bottomChoices = [
        CaptionOption(emoji: "🤖", caption: "You are heartless."),
        CaptionOption(emoji: "😂", caption: "Wow! That's funny!"),
        CaptionOption(emoji: "👽", caption: "Dumb humans!"),
        CaptionOption(emoji: "🤷", caption: "Beats me!?!?"),
        CaptionOption(emoji: "👨‍💻", caption: "Not now. I'm in the zone.")
    ]
    
    // #28
    var currentImage: UIImage!
    
    // #29
    var fontSize: Double = 70.0
    var selectedFont = "Avenir Next Heavy"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        topSegmentedControl.removeAllSegments()
        for choice in topChoices {
            topSegmentedControl.insertSegment(withTitle: choice.emoji, at: topChoices.count, animated: false)
        }
        topSegmentedControl.selectedSegmentIndex = 0
        
        bottomSegmentedControl.removeAllSegments()
        for choice in bottomChoices {
            bottomSegmentedControl.insertSegment(withTitle: choice.emoji, at: bottomChoices.count, animated: false)
        }
        bottomSegmentedControl.selectedSegmentIndex = 0
        
        updateCaptions()
    }
    
    // MARK: - IB Actions

    @IBAction func segmentedControlChanged(_ sender: Any) {
        updateCaptions()
    }
    
    @IBAction func dragToplabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            topCaptionLabel.center = sender.location(in: view)
        }
    }
    
    @IBAction func dragBottomLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            bottomCaptionLabel.center = sender.location(in: view)
        }
    }
    
    @IBAction func importPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // #34
    @IBAction func saveMeme(_ sender: Any) {
        // #35
        saveImageAndText()
    }
    
    
    
    
    // MARK: - Instance Methods
    func updateCaptions() {
        let topIndex = topSegmentedControl.selectedSegmentIndex
        topCaptionLabel.text = topChoices[topIndex].caption
        
        let bottomIndex = bottomSegmentedControl.selectedSegmentIndex
        bottomCaptionLabel.text = bottomChoices[bottomIndex].caption
    }
    
    // method to add selected photo from photo library to imageView
    // #14
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // #15
        guard let image = info[.editedImage] as? UIImage else { return }
        
        imageView.image = image
        dismiss(animated: true)
    }
    
    // method to get size of photo, add the text to the photo, and then call the function to save the image to Photo Library
    // #31
    func saveImageAndText() {
        if imageView.image == nil {
            let alert = UIAlertController(title: "You did not pick an image", message: "Please pick an image and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
        // get size of image from chosen image
        guard let width = imageView.image?.size.width else { return }
        guard let height = imageView.image?.size.height else { return }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        let pic = renderer.image { context in
            
            guard let image = imageView.image else { return }
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let strokeAttributes: [NSAttributedString.Key : Any] = [
                .strokeColor : UIColor.black,
                .foregroundColor : UIColor.white,
                .strokeWidth : -2.0,
                .paragraphStyle : paragraphStyle,
                .font : UIFont(name: selectedFont, size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: 50)
            ]
            let topAttributedString = NSAttributedString(string: topCaptionLabel.text!, attributes: strokeAttributes)
            // start with (with: CGRect(x: 0, y: 0,...
            topAttributedString.draw(with: CGRect(x: 0, y: 5, width: width, height: height / 4), options: .usesLineFragmentOrigin, context: nil)
            
            let bottomAttributedString = NSAttributedString(string: bottomCaptionLabel.text!, attributes: strokeAttributes)

            // use 100 for single line and 120 for 2 lines
            // start with (with: CGRect(x: 0, y: 0,...
            bottomAttributedString.draw(with: CGRect(x: 0, y: height - CGFloat(fontSize + 120), width: width, height: height /  4), options: .usesLineFragmentOrigin, context: nil)
            
        }
        
        UIImageWriteToSavedPhotosAlbum(pic, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil) // #33
        
        currentImage = pic
    }
    
    // method to save image to Photo Library
    // #32
    @objc func imageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // if we get back an error
            let alert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Your meme has been saved to your photos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
}

