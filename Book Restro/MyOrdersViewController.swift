
import UIKit

class MyOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var data = NSMutableArray()
    var c = 0
    override func viewDidLoad() {
        super.viewDidLoad()

       reloadData()       
        
        //guard let number = URL(string: "telprompt://" + str) else { return }
        //UIApplication.shared.open(number, options: [:], completionHandler: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        c = indexPath.row
    }

    @IBOutlet weak var tblView: UITableView!
    func reloadData()
    {
        let dml = DMLOperation()
        let u = UserDefaults()
        let s = String(format:"SELECT * FROM all_bookings WHERE user_id=%@ ORDER BY book_date DESC",u.value(forKey: "id") as! String)
        data = dml.allBookings(quey: s)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var mycell=MyBookingsTableViewCell()
        mycell=tableView.dequeueReusableCell(withIdentifier: "cell3") as! MyBookingsTableViewCell
        let d = data.object(at: indexPath.row) as! NSDictionary
        
        let dml = DMLOperation()
        let u = UserDefaults()
        let s1 = String(format:"SELECT * FROM restro_overview WHERE id=%@",(d.value(forKey: "restro_id") as! String?)!)
        
        mycell.lblName.text=dml.restroName(query: s1, ind:1)
        var s = ""
        s = String(format: "%@.jpg", (d.value(forKey: "restro_id") as! String?)!)
        mycell.imgView.image=UIImage(named: s)
        var s2 = d.value(forKey: "book_date") as! String?
        let index = s2?.index((s2?.startIndex)!, offsetBy: 10)
        s2 = s2?.substring(to: index!)
            
        mycell.lblDate.text = s2
        mycell.lblTime.text = d.value(forKey: "book_time") as! String?
        
        mycell.btnCall.tag = indexPath.row
        mycell.btnCancel.tag = indexPath.row
        mycell.btnCancel.addTarget(self, action: #selector(btnCancel(btn:)), for:.touchUpInside)
        mycell.btnCall.addTarget(self, action: #selector(btnCall(btn:)), for:.touchUpInside)
        return mycell
    }
    func btnCall(btn:UIButton) {
        let dml = DMLOperation()
        let d = data.object(at: btn.tag) as! NSDictionary
        let s1 = String(format:"SELECT * FROM restro_overview WHERE id=%@",(d.value(forKey: "restro_id") as! String?)!)
        var s2 = dml.restroName(query: s1, ind:4)
        s2 = s2.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "telprompt://\(s2)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func btnCancel(btn:UIButton) {
        let d = data.object(at: btn.tag) as! NSDictionary
        let alert=UIAlertController(title: "Clear History", message: "Are you sure to Cancel Booking?", preferredStyle: .alert)
        
        //Set all statastics to zero
        let yes=UIAlertAction(title: "YES", style: .destructive, handler: {(alert: UIAlertAction!) in
            let dml = DMLOperation()
            let s = String(format:"DELETE FROM all_bookings WHERE id=%@", (d.value(forKey: "id") as! String?)!)
            dml.dmlservices(quey: s)
            self.reloadData()
            self.tblView.reloadData()
            
        })
        alert.addAction(yes)
        let ok=UIAlertAction(title: "NO", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
