//
//  SelfieViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 11/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class SelfieViewController: UIViewController {

    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    var user: User!
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabController = self.parent as? UITabBarControllerMainViewController {
            tabController.navigationItem.title = "Settings"
        }
        ImageView.backgroundColor = .secondarySystemBackground
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white,for: .normal)
        button.setTitle("Take a selfie", for: .normal)
        
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white,for: .normal)
        saveButton.setTitle("Save selfie", for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.setTitleColor(.white,for: .normal)
                //mostrar a imagem caso exista
        if(!(user.imageFRurl?.isEmpty ?? true)){
            //ImageView.loadFrom(URLAddress: user.imageFRurl!)
            setImageFromStringrURL(stringUrl: user.imageFRurl!)
        }
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string:stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error handling...
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                self.ImageView.image = image
            }
        }.resume()
      }
    }
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let loginViewController=UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "UsersViewController")
        if let sceneDelegate=view.window?.windowScene?.delegate as? SceneDelegate,
           let window=sceneDelegate.window{
            window.rootViewController=loginViewController
        }
    }
    
    @IBAction func didTapSaveButton(){
        guard let imageData = ImageView.image?.pngData()
        else{
            return
        }
        
        //upload image
        //getUrl
        //save url
        
        storage.child("images/" + (user!.id ?? "tes") + ".png").putData(imageData,
                                                                        metadata: nil,
                                                                        completion: { _, error in
            guard error == nil else{
                print("failed to upload")
                return
            }
            self.storage.child("images/" + (self.user!.id ?? "tes") + ".png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else{
                    return
                }
                let urlString = url.absoluteString
                //guardar este url na firebase
                
                let db = Firestore.firestore()
                db.collection("user")
                    .whereField(FieldPath.documentID(), isEqualTo: self.user.id)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print(err)
                        } else if querySnapshot!.documents.count != 1 {
                            // Perhaps this is an error for you?
                        } else {
                            let document = querySnapshot!.documents.first
                            document?.reference.updateData([
                                "imageFRurl": urlString
                            ])
                        }
                    }
                
                
                print(urlString)
            })
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowLoging") {
            let secondView = segue.destination as! UsersTableViewController
            
        }
    }
}



extension SelfieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else{
            return
        }
        //temos uma imagem válida
        ImageView.image = image
    }
}



extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}


