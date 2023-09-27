//
//  MBProgressHUD.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 27/09/2023.
//

import Foundation
import MBProgressHUD

//for Loading...
extension UIViewController {
    
    func showHUD(withTitle title:String, withDescription description:String,withDelay delay:TimeInterval){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = title
        hud.isUserInteractionEnabled = true
        hud.detailsLabel.text = description
        hud.show(animated: true)
        self.view.isUserInteractionEnabled = true
        hud.hide(animated: true,afterDelay: delay)
    }
    
    func hideHUD(){
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
}
