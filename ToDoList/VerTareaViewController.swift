//
//  VerTareaViewController.swift
//  ToDoList
//
//  Created by Paola Garcia on 04/06/22.
//

import UIKit

class VerTareaViewController: UIViewController {

    
    var recibirTarea: Tarea?
    @IBOutlet weak var textoArea: UITextField!
    @IBOutlet weak var fechatareaPicker: UIDatePicker!
    @IBOutlet weak var imagen: UIImageView!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //crear gestura a la imagen
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        
        imagen.addGestureRecognizer(gestura)
        imagen.isUserInteractionEnabled = true
        
        textoArea.text = recibirTarea?.nombre
        fechatareaPicker.date = recibirTarea?.fecha ?? Date()
        let image = UIImage(data: (recibirTarea?.imagen!)!)
        imagen.image = image
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    @objc func clickImagen(gestura: UITapGestureRecognizer){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate=self
        vc.allowsEditing=true
        present(vc, animated: true)
    }
}

extension VerTareaViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imagen.image=imagenSeleccionada
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
