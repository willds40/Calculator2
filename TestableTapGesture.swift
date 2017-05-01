import UIKit
class TestableTapGesture: UITapGestureRecognizer{
    let testTarget: AnyObject?
    let testAction: Selector
    var testLocation: CGPoint?
    var testState: UIGestureRecognizerState?
    
    override init(target: Any?, action: Selector?) {
        testTarget = target as AnyObject?
        testAction = action!
        super.init(target: target, action: action)
    }
    
    func perfomTouch(location: CGPoint?,state: UIGestureRecognizerState) {
        testLocation = location
        testState = state
        testTarget?.performSelector(onMainThread: testAction, with: self, waitUntilDone: true)
    }
    
    override func location(in view: UIView?) -> CGPoint {
        if let testLocation = testLocation {
            return testLocation
        }
        return super.location(in: view)
    }
    
    override var state: UIGestureRecognizerState {
        if let testState = testState {
            return testState
        }
        return super.state
    }
}
