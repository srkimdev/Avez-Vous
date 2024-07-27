//
//  FileManager.swift
//  Avez Vous
//
//  Created by 김성률 on 7/28/24.
//

import UIKit

extension UIViewController {
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
    
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
    
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
    
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
    
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
//    func loadImageToDocument(filename: String) -> UIImage? {
//        
////        if #available(iOS 16.0, *) {
////            filePath = fileURL.path()
////        } else {
////            filePath = fileURL.path
////        }
//    
//       guard let documentDirectory = FileManager.default.urls(
//           for: .documentDirectory,
//           in: .userDomainMask).first else { return nil }
//    
//       let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
//        
//       //이 경로에 실제로 파일이 존재하는 지 확인
//       if FileManager.default.fileExists(atPath: fileURL.path()) {
//           return UIImage(contentsOfFile: fileURL.path())
//       } else {
//           return UIImage(systemName: "star.fill")
//       }
//    
//    }
//    
//    func removeImageFromDocument(filename: String) {
//    
//       guard let documentDirectory = FileManager.default.urls(
//           for: .documentDirectory,
//           in: .userDomainMask).first else { return }
//    
//       let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
//    
//       if FileManager.default.fileExists(atPath: fileURL.path()) {
//    
//           do {
//               try FileManager.default.removeItem(atPath: fileURL.path())
//           } catch {
//               print("file remove error", error)
//           }
//    
//       } else {
//           print("file no exist")
//       }
//    
//    }

    //if let image = photoImageView.image {
    //    saveImageToDocument(image: image, filename: "\(data.id)") // id 값으로 파일 이름 설정
    //}

    //cell.thumbnailImageView.image = loadImageToDocument(filename: "\(data.id)")

    //let data = list[indexPath.row] // -> 이렇게 하지 않았을 때의 이슈 (인덱스)
    //removeImageFromDocument(filename: "\(data.id)")

    
    
}
