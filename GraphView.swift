
import UIKit
@IBDesignable
class GraphView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 30.00{didSet{setNeedsDisplay()}}
    var originHasBeenChanged = false
    var graphOrigin:CGPoint = CGPoint(x:0, y:0){didSet{setNeedsDisplay()}}
    var start:CGPoint = CGPoint(x:0, y:0){didSet{setNeedsDisplay()}}
    var end:CGPoint = CGPoint(x:0, y:0){didSet{setNeedsDisplay()}}
    var newYPoint:CGPoint = CGPoint(x:0, y:0){didSet{setNeedsDisplay()}}
    var newXPoint:CGPoint = CGPoint(x:0, y:0){didSet{setNeedsDisplay()}}
  
    func moveOrigin(recognizer: UITapGestureRecognizer){
        let touchPoint = recognizer.location(in: self)
        switch recognizer.state{
        case .ended:
            graphOrigin = touchPoint
        default: break
        }
    }
    
    func drawfunction(x:Double, y:Double){
        newXPoint.x = CGFloat(x) * scale
        newXPoint.y = CGFloat(y) * scale
    }
    
    func changeScale(recognizer: UIPinchGestureRecognizer){
        switch recognizer.state{
        case.changed,.ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default: break
        }
    }
    override func draw(_ rect: CGRect) {
        var axixDrawer:AxesDrawer = AxesDrawer()
        if !originHasBeenChanged {
            graphOrigin = CGPoint(x: bounds.midX, y: bounds.midY)
        }
        axixDrawer.contentScaleFactor = 1.0
        axixDrawer.drawAxes(in: rect, origin: graphOrigin, pointsPerUnit: CGFloat(scale))
        
        originHasBeenChanged = true
        
        if originHasBeenChanged{
            
            let newPoint1 = CGPoint(x:newXPoint.x,y:newXPoint.y)
            let newPoint2 = CGPoint(x: (-1 * (newXPoint.x * 15 )), y: (newXPoint.y * 15))
            let path = UIBezierPath()
            
            path.move(to: newPoint1)
            path.addLine(to: newPoint2)
            path.close()
            
            UIColor.red.set()
            path.lineWidth = 5.0
            path.stroke()
            path.fill()
        }
    }
    
}
