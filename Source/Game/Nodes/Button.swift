////
/// Button.swift
//

enum ButtonStyle {
    case squareSized(CGFloat)
    case rectSized(CGFloat, CGFloat)
    case circleSized(CGFloat)
    case rectToFit
    case none

    static var square: ButtonStyle = .squareSized(50)
    static var circle: ButtonStyle = .circleSized(60)

    var size: CGSize {
        switch self {
        case let .squareSized(size): return CGSize(size)
        case let .rectSized(width, height): return CGSize(width, height)
        case let .circleSized(size): return CGSize(size)
        default: return .zero
        }
    }

}

class Button: TextNode {
    enum ButtonBehavior {
        case Disable
    }

    var style: ButtonStyle = .none {
        didSet { updateButtonStyle() }
    }
    var preferredScale: CGFloat = 1
    var backgroundColor: Int? = 0x0 {
        didSet { updateButtonStyle() }
    }
    var borderColor: Int? {
        didSet { updateButtonStyle() }
    }

    private var prevZ: CGFloat = 0
    override var zPosition: CGFloat {
        didSet {
            buttonStyleNode.zPosition = zPosition - 0.1
            buttonBackgroundNode.zPosition = zPosition - 0.2
        }
    }

    private var buttonStyleNode = SKSpriteNode(id: .none)
    private var buttonBackgroundNode = SKSpriteNode(id: .none)
    private var alphaOverride = true
    override var alpha: CGFloat {
        didSet {
            alphaOverride = false
        }
    }
    var isEnabled = true {
        didSet {
            if alphaOverride {
                alpha = isEnabled ? 1 : 0.25
                alphaOverride = true
            }
            touchableComponent?.isEnabled = isEnabled
        }
    }

    func onTapped(behavior: ButtonBehavior) -> Self {
        onTapped {
            self.touchableComponent?.isEnabled = false
        }
        return self
    }

    typealias OnTapped = Block
    var _onTapped: [OnTapped] = []
    func onTapped(_ handler: @escaping OnTapped) { _onTapped.append(handler) }
    func offTapped() { _onTapped = [] }

    override func setScale(_ scale: CGFloat) {
        preferredScale = scale
        super.setScale(scale)
    }

    override func reset() {
        super.reset()
        _onTapped = []
    }

    required init() {
        super.init()

        buttonStyleNode.zPosition = zPosition - 0.1
        self << buttonStyleNode

        buttonBackgroundNode.zPosition = zPosition - 0.2
        self << buttonBackgroundNode

        let touchableComponent = TouchableComponent()
        touchableComponent.containsTouchTest = { [unowned self] (_, location) in
            return self.containsTouchTest(at: location)
        }
        touchableComponent.on(.enter) { _ in
            self.highlight()
        }
        touchableComponent.on(.exit) { _ in
            self.unhighlight()
        }
        touchableComponent.on(.upInside) { _ in
            for handler in self._onTapped {
                handler()
            }
        }
        addComponent(touchableComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateTextNodes() {
        super.updateTextNodes()
        updateButtonStyle()
    }

    func containsTouchTest(at location: CGPoint) -> Bool {
        let width = max(44, size.width)
        let height = max(44, size.height)

        var minX: CGFloat, maxX: CGFloat
        var minY = -height / 2
        var maxY = height / 2

        switch alignment {
        case .left:
            minX = 0
            maxX = width
        case .right:
            minX = -width
            maxX = 0
        default:
            minX = -width / 2
            maxX = width / 2
        }

        minX -= margins.left
        maxX += margins.right
        minY -= margins.bottom
        maxY += margins.top

        return location.x >= minX && location.x <= maxX && abs(location.y) <= height / 2
    }

    private func updateButtonStyle() {
        var textureStyle = style

        switch style {
        case .none:
            break
        case .rectToFit:
            let margin: CGFloat = 10
            size = CGSize(CGFloat(ceil(textSize.width)) + margin, CGFloat(ceil(textSize.height)) + margin)
            textureStyle = .rectSized(size.width, size.height)
        default:
            size = style.size
        }
        buttonStyleNode.textureId(.button(style: textureStyle, borderColor: borderColor))

        var backgroundId: ImageIdentifier = .none
        if let backgroundColor = backgroundColor {
            switch style {
            case .none: break
            case .circleSized:
                backgroundId = .fillColorCircle(size: size, color: backgroundColor)
            default:
                backgroundId = .fillColorBox(size: size, color: backgroundColor)
            }
        }
        buttonBackgroundNode.textureId(backgroundId)

        let anchorPoint: CGPoint
        switch alignment {
        case .left:
            anchorPoint = CGPoint(0, 0.5)
        case .right:
            anchorPoint = CGPoint(1, 0.5)
        default:
            anchorPoint = CGPoint(0.5, 0.5)
        }

        buttonStyleNode.anchorPoint = anchorPoint
        buttonBackgroundNode.anchorPoint = anchorPoint
    }

    func highlight() {
        prevZ = zPosition
        zPosition += 0.5
        super.setScale(preferredScale * 1.1)
    }

    func unhighlight() {
        zPosition = prevZ
        super.setScale(preferredScale)
    }

}
