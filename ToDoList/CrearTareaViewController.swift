//
//  CrearTareaViewController.swift
//  ToDoList
//
//  Created by Paola Garcia on 04/06/22.
//

import UIKit
import CoreData

class CrearTareaViewController: UIViewController,UITextFieldDelegate {


    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var fechatareaPicker: UIDatePicker!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var textoArea: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //crear gestura a la imagen
        
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        
        imagen.addGestureRecognizer(gestura)
        imagen.isUserInteractionEnabled = true
        
        textoArea.delegate=self
        textoArea.becomeFirstResponder()
    }
    
    @objc func clickImagen(gestura: UITapGestureRecognizer){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate=self
        vc.allowsEditing=true
        present(vc, animated: true)
    }
    

    @IBAction func btrnGuardar(_ sender: UIBarButtonItem) {
        //let entity = NSEntityDescription.entity(forEntityName: "Tarea", in: self.contexto)
        let fechatarea=fechatareaPicker.date
        //entity?.name = textoArea.text
        
        let nuevaTarea = Tarea(context: contexto)
        nuevaTarea.fecha=fechatarea
        nuevaTarea.imagen=imagen.image?.pngData()
        nuevaTarea.nombre=textoArea.text
        
        self.guardar()
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func guardar(){
        do{
            try contexto.save()
            print("Se guardo correctamente")
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

extension CrearTareaViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
