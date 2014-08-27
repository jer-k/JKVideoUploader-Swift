//
//  ViewController.swift
//  JKVideoUploader-Swift
//
//  Created by Jeremy Kreutzbender on 8/20/14.
//  Copyright (c) 2014 Jeremy Kreutzbender. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet private weak var previewContainer: UIView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let previewLayer = CALayer()
        previewLayer.frame = previewContainer.bounds
//        previewLayer.setAffineTransform(CGAffineTransformMakeRotation(M_PI/2))
        self.view.layer.addSublayer(previewLayer)
//        CALayer *customPreviewLayer = [CALayer layer];
//        customPreviewLayer.bounds = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
//        customPreviewLayer.position = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
//        customPreviewLayer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

