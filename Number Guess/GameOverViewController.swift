import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLable.text="You Scored: \(score)"
        // Do any additional setup after loading the view.
    }
    var score:Int=0
    var callOnExit:(()->Void)!
    @IBOutlet weak var scoreLable: UILabel!
    @IBAction func onExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        callOnExit()
    }
}
