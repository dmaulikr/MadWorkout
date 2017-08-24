// ============================
import Foundation
import WatchKit
// ============================
class WorkoutController: WKInterfaceController {
    // ========================================================================= Outlets
    @IBOutlet var displayLabel: WKInterfaceLabel!
    //========================================================================== Fonctions
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let temp = context as? [String : String]
        displayLabel.setText(temp?["workout"])
    }
    //--------------------
}
// ============================
