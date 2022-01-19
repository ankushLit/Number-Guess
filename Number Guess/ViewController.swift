import UIKit
import iOSDropDown
/*
 Installation Instruction (Podfile used)
 1.Open terminal -> Go to project directory -> run command "pod install"
 2.Open .xcworkspace file from the project folder to run the application
 */
class ViewController: UIViewController {

    @IBOutlet weak var levelDropDown: DropDown!
    @IBOutlet weak var errorLable: UILabel!
    var selectedLevel=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInfoButton(btn: infoButton)
        levelDropDown.rowBackgroundColor=UIColor(red: 205/255, green: 144/255, blue: 235/255, alpha: 1)
        levelDropDown.selectedRowColor=UIColor.purple
        levelDropDown.optionArray=["Level 1","Level 2","Level 3"]
        levelDropDown.didSelect{(selectedText , index ,id) in
        self.selectedLevel = selectedText
        self.errorLable.text=""
        self.errorLable.backgroundColor=UIColor.clear
        }
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
        if selectedLevel.isEmpty{
            errorLable.backgroundColor=UIColor.white.withAlphaComponent(0.5)
            errorLable.text="Please select level of difficulty"
        }else{
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            secondViewController.selectedLevel=self.selectedLevel
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    @IBOutlet weak var infoButton: UIButton!
    
    func createInfoButton(btn:UIButton){
        btn.layer.borderWidth=0.8
        btn.layer.cornerRadius=0.5*btn.bounds.size.width
        btn.layer.borderColor=(UIColor(red:52/255,green: 120/255,blue: 246/255,alpha: 1)).cgColor
    }
    
}

