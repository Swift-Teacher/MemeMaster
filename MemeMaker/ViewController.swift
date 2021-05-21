//
//  ViewController.swift
//  MemeMaker
//
//  Created by Brian Foutty on 3/17/21.
//  This is the concept app version.

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
    
}

