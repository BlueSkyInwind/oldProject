//
//  CameraManager.swift
//  fxdProduct
//        
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias SelectImage = ((_ image:UIImage) -> Void)

class CameraManager: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc static let shareInstance = CameraManager()

    var imagePickerController:UIImagePickerController!
    var selectImage:SelectImage?
    
    override init() {
        
    }
    
    @objc func pushCameraVC(_ vc:UIViewController,_ uploadImage:@escaping SelectImage)  {
        imagePickerController = UIImagePickerController.init();
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        selectImage = uploadImage
        vc.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
//        let imgData = UIImageJPEGRepresentation(img!,0.6)
//        let resultImage = UIImage.init(data: imgData!)
        if selectImage != nil {
            selectImage!(img!)
        }
        picker.dismiss(animated:true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        imagePickerController.dismiss(animated:true, completion:nil)
    }
    
}
