//
//  ViewController.swift
//  HomeAutomation
//
//  Created by Edwin Candinegara on 26/1/17.
//  Copyright © 2017 Edwin Candinegara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let SEGMENT_AC_ON = 0
    private let SEGMENT_AC_OFF = 1
    
    private var prevSegmentState: Int = -1
    private var currentOverlay: UIView?
    @IBOutlet weak var acStateSegmentControl: UISegmentedControl!
    @IBOutlet var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        AcController.getInstance()?.getCurrentAcState(callback: self.handleCurrentAcState)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleCurrentAcState(_ success: Bool, _ acState: Bool) {
        if success {
            self.acStateSegmentControl.selectedSegmentIndex = acState ? SEGMENT_AC_ON : SEGMENT_AC_OFF
        } else {
            let alertController = UIAlertController(
                title: "Current State",
                message: "Cannot retrieve current state!",
                preferredStyle: .alert
            )
            
            alertController.addAction(UIAlertAction(
                title: "Dismiss",
                style: .default,
                handler: nil
            ))
                
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func handleChangeAcState(_ success: Bool, _ acState: Bool) {
        if success {
            self.acStateSegmentControl.selectedSegmentIndex = acState ? SEGMENT_AC_ON : SEGMENT_AC_OFF
        } else {
            let alertController = UIAlertController(
                title: "Change AC State",
                message: "Cannot change AC state!",
                preferredStyle: .alert
            )
            
            alertController.addAction(UIAlertAction(
                title: "Dismiss",
                style: .default,
                handler: nil
            ))
            
            self.present(alertController, animated: true, completion: nil)
            self.acStateSegmentControl.selectedSegmentIndex = self.prevSegmentState
        }
        
        self.hideActivityLoadingIndicator()
    }
    
    private func showActivityLoadingIndicator(loadingText: String?) {
        let overlay = UIView(frame: self.mainView.frame)
        overlay.center = self.mainView.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        
        self.mainView.addSubview(overlay)
        self.mainView.bringSubview(toFront: overlay)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.center = overlay.center
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        self.currentOverlay = overlay
    }
    
    private func hideActivityLoadingIndicator() {
        if self.currentOverlay != nil {
            self.currentOverlay?.removeFromSuperview()
            self.currentOverlay = nil
        }
    }


    @IBAction func onAcStateChange(_ sender: UISegmentedControl) {
        // The selected segment index is already the switched one (new state) --> need to flip
        self.prevSegmentState = 1 - sender.selectedSegmentIndex
        self.showActivityLoadingIndicator(loadingText: "Loading...")
        
        switch self.acStateSegmentControl.selectedSegmentIndex {
        case SEGMENT_AC_ON:
            AcController.getInstance()?.changeAcState(
                acState: true,
                callback: self.handleChangeAcState
            )
            
        default:
            AcController.getInstance()?.changeAcState(
                acState: false,
                callback: self.handleChangeAcState
            )
        }
    }
}

