import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if(result == "win"){
            mainLable.text = "Yayyy!! You Won"
        }
        msgLable.text = "Your Score is now: \(score)"
        // Do any additional setup after loading the view.
    }
    var score:Int=0
    var result:String=""
    var callOnExit:(()->Void)!
    
    @IBOutlet weak var msgLable: UILabel!
    @IBOutlet weak var mainLable: UILabel!
    @IBAction func onTryAgain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onExit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        callOnExit()
    }
}
