// ============================
import UIKit
// ============================
class WorkoutsView: UIViewController {
    // ========================================================================= Attributs
    var theDatabase: [String : [[String : String]]]!
    // ========================================================================= Fonctions predefinies du Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
    }
    // ============================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //========================================================================== Fonctions
    func getDates() -> [String] {
        var tempArray = [""]
        
        for (a, _) in  self.theDatabase {
            tempArray.append(a)
        }
        
        tempArray.remove(at: 0)
        
        return tempArray
    }
    // ========================================================================= TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.theDatabase.count
    }
    // Contenu de la rangee
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 18.0)
        cell.textLabel!.text = self.getDates()[indexPath.row]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    // Lorsqu'une rangee est selectionnee
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        Shared.sharedInstance.theRow = indexPath.row
        performSegue(withIdentifier: "theSegway", sender: nil)
    }
    // Supprimer une rangee
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.theDatabase[self.getDates()[indexPath.row]] = nil
            Shared.sharedInstance.saveDatabase(self.theDatabase)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    // ============================
}























