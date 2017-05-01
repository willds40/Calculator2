
import UIKit

class GraphViewController: UIViewController {
    var tapGestureRecognizer:TestableTapGesture!
    var newXPoint:Double = Double(0.0) {
        didSet{updateUI()}}
    var newYPoint:Double = Double(0.0) {
        didSet{updateUI()}}

    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBOutlet weak var graphView: GraphView!{
        didSet{
            graphView.addGestureRecognizer(UIPinchGestureRecognizer (target: graphView, action: #selector(graphView.changeScale(recognizer:))))
            
            tapGestureRecognizer = TestableTapGesture(target:graphView , action: #selector(graphView.moveOrigin(recognizer:)))
            graphView.addGestureRecognizer(tapGestureRecognizer)
            updateUI()
            
        }
    }
    private var brain = CalculatorBrain(){
        didSet{
            updateUI()
        }
    }
    private func updateUI(){
        if graphView != nil {
            graphView.drawfunction(x: newXPoint, y: newYPoint)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
