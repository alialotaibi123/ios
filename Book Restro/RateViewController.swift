
import UIKit

class RateViewController: UIViewController {

    var rate = 3
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RateViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn1(_ sender: Any) {
        img2.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img3.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img4.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img5.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img1.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        rate = 1
        lblRate.text = String(format: "%d", rate)
    }
    @IBAction func btn2(_ sender: Any) {
        img2.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img3.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img4.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img5.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img1.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        rate = 2
        lblRate.text = String(format: "%d", rate)
    }
    @IBAction func btn3(_ sender: Any) {
        img2.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img3.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img4.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img5.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img1.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        rate = 3
        lblRate.text = String(format: "%d", rate)
    }
    @IBAction func btn4(_ sender: Any) {
        img2.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img3.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img4.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img5.setBackgroundImage(UIImage(named:"rate2.png"), for: .normal)
        img1.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        rate = 4
        lblRate.text = String(format: "%d", rate)
    }
    @IBAction func btn5(_ sender: Any) {
        img2.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img3.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img4.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img5.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        img1.setBackgroundImage(UIImage(named:"rate1.png"), for: .normal)
        rate = 5
        lblRate.text = String(format: "%d", rate)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        let dml = DMLOperation()
        let u = UserDefaults()
        let m = dml.selectMaxRateId()
        let s1 = u.value(forKey: "name") as! String
        let s2 = u.value(forKey: "rId") as! String
        let s3 = String(format:"%d",rate)
        //let s4 = String(format:"%d",rate)
        
        let s = String(format: "INSERT INTO ratings VALUES(%@,'%@',%@,%@,'%@')", m,s1,s2,s3,txtReview.text)
        dml.dmlservices(quey: s)
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var img1: UIButton!
    @IBOutlet weak var img2: UIButton!
    @IBOutlet weak var img3: UIButton!
    @IBOutlet weak var img4: UIButton!
    @IBOutlet weak var img5: UIButton!
    @IBOutlet weak var txtReview: UITextView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
