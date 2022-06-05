//
//  ViewController.swift
//  ToDoList
//
//  Created by Paola Garcia on 04/06/22.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {

    // Create Date
    let date = Date()

    var tareaParaEnviar: Tarea?
    // Create Date Formatter
    let dateFormatter = DateFormatter()
    
    var listaTareas = [Tarea]()
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tablaTareas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tablaTareas.delegate=self
        tablaTareas.dataSource=self
        leerTareas()
    }
    
    func leerTareas(){
        let solicitud : NSFetchRequest<Tarea> = Tarea.fetchRequest()
        do{
            listaTareas = try contexto.fetch(solicitud)
            print(listaTareas.count)
        }catch{
            print(error.localizedDescription)
        }
        self.tablaTareas.reloadData()
    }//de la funcion leer tareas
    
    func actualizar(){
        self.tablaTareas.reloadData()
    }
}// de la clase

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda=tablaTareas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text=listaTareas[indexPath.row].nombre
        dateFormatter.dateStyle = .medium
        celda.detailTextLabel?.text = dateFormatter.string(from: listaTareas[indexPath.row].fecha ?? date)
        let imagenes = UIImage(data: listaTareas[indexPath.row].imagen!)
        celda.imageView?.image=imagenes
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tareaParaEnviar = listaTareas[indexPath.row]
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit"{
            let objDestino = segue.destination as! VerTareaViewController
            objDestino.recibirTarea = tareaParaEnviar
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .normal, title: "Eliminar"){_,_,_ in
            self.contexto.delete(self.listaTareas[indexPath.row])
            self.listaTareas.remove(at: indexPath.row)
        }
        accionEliminar.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    
    
}
