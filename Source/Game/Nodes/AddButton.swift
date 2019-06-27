////
/// AddButton.swift
//

class AddButton: Button {
    private var dragBeginPoint: CGPoint?
    private var addToPoint: CGPoint?
    private var newNode = MathNode()

    required init() {
        super.init()
        style = .CircleSized(20)
        text = "+"
        borderColor = 0xffffff

        newNode.alpha = 0
        newNode.op = .NoOpSelected
        self << newNode

        let defaultOffset = CGPoint(x: 60, y: -10)

        touchableComponent?.off(.Enter, .Exit)

        touchableComponent?.on(.Down) { pt in
            if let mainframe = self.world as? Mainframe {
                mainframe.hidePanel()
            }

            self.addToPoint = nil

            let newPoint = pt + defaultOffset
            self.dragBeginPoint = newPoint
            self.newNode.position = newPoint
            self.newNode.fadeTo(0.5, rate: 3.333)
        }
        touchableComponent?.on(.DragMoved) { pt in
            let newPoint = pt + defaultOffset
            self.newNode.position = newPoint
            self.addToPoint = newPoint
        }
        touchableComponent?.on(.Up) { pt in
            self.addMainframeNode(at: self.addToPoint)
            self.newNode.fadeTo(0, start: 0, rate: 3.333) // to cancel previous fade-in
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addMainframeNode(at delta: CGPoint?) {
        guard let mainframe = world as? Mainframe else { return }

        mainframe.addTopNode(MathNode(), at: delta.map { position + $0 })
    }

}
