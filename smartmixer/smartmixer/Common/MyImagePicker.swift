//
//  MyImagePicker.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/10/15.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

class MyImagePicker: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
