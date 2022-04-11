//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/19.
//

import Foundation
import UIKit


class LocalFileManager{
    
    
    static let instance = LocalFileManager()
    
    
    init(){
        
    }
    
    func createFolderIfNeeded(folderName:String){
    

        guard let getUrlInUserPhone = getFolderURL(folderName: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: getUrlInUserPhone.path){
            do {
               try FileManager.default.createDirectory(at: getUrlInUserPhone, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error : Can't create at \(folderName) , Reason \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    func saveImage(image:UIImage,folderName:String,imageName:String){

        
        createFolderIfNeeded(folderName:folderName)
        
        if let savedImage = image.pngData(),
           let savedURL = getImageURL(folderName: folderName, imageName: imageName) {
            
            do {
                try savedImage.write(to: savedURL)
            } catch let error {
                print("Error : \(error.localizedDescription) ")
            }
        }
    }
    
    
    func getImage(folderName:String,imageName:String) -> UIImage? {
        
        guard let imageURL = getImageURL(folderName: folderName, imageName: imageName) ,
              FileManager.default.fileExists(atPath: imageURL.path) else {
                  return nil
        }
        
        return UIImage(contentsOfFile: imageURL.path)
        
    }
    
    
    
    
    func getFolderURL(folderName:String) -> URL? {
        
        guard let urlInUserPhone = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        
        return urlInUserPhone.appendingPathComponent(folderName)
        
    }

    
    func getImageURL(folderName:String,imageName:String) -> URL? {
        
        
        guard let getUrlInUserPhone = getFolderURL(folderName: folderName) else {
            return nil
        }
        
        return getUrlInUserPhone.appendingPathComponent(imageName)
    }
    
    
}
