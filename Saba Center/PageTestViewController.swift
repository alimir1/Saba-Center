import UIKit

class PageTestViewController: UIViewController {
    
//    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(scrollView)
        for index in 0..<4 {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            scrollView.isPagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        
    }
}
