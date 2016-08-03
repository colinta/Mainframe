//
//  Button.swift
//  FlatoutWar
//
//  Created by Colin Gray on 1/1/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

enum ButtonStyle {
    case Square
    case SquareSized(CGFloat)
    case RectSized(CGFloat, CGFloat)
    case Circle
    case CircleSized(CGFloat)
    case RectToFit
    case None

    var size: CGSize {
        switch self {
        case .Square: return CGSize(50)
        case .Circle: return CGSize(60)
        case let .SquareSized(size): return CGSize(size)
        case let .RectSized(width, height): return CGSize(width, height)
        case let .CircleSized(size): return CGSize(size)
        default: return .zero
        }
    }

}

class Button: TextNode {
    enum ButtonBehavior {
        case Disable
    }

    var style: ButtonStyle = .None {
        didSet { updateButtonStyle() }
    }
    var preferredScale: CGFloat = 1
    var background: Int? = 0x0 {
        didSet { updateButtonStyle() }
    }
    var border: Int? {
        didSet { updateButtonStyle() }
    }

    private var prevZ: CGFloat = 0
    override var zPosition: CGFloat {
        didSet {
            buttonStyleNode.zPosition = zPosition - 0.1
            buttonBackgroundNode.zPosition = zPosition - 0.2
        }
    }

    private var buttonStyleNode: SKSpriteNode!
    private var buttonBackgroundNode: SKSpriteNode!
    private var alphaOverride = true
    override var alpha: CGFloat {
        didSet {
            alphaOverride = false
        }
    }
    var enabled = true {
        didSet {
            if alphaOverride {
                alpha = enabled ? 1 : 0.25
                alphaOverride = true
            }
            touchableComponent?.enabled = enabled
        }
    }

    func onTapped(behavior: ButtonBehavior) -> Self {
        onTapped {
            self.touchableComponent?.enabled = false
        }
        return self
    }

    typealias OnTapped = Block
    var _onTapped: [OnTapped] = []
    func onTapped(handler: OnTapped) { _onTapped  << handler }
    func offTapped() { _onTapped = [] }

    override func setScale(scale: CGFloat) {
        preferredScale = scale
        super.setScale(scale)
    }

    override func reset() {
        super.reset()
        _onTapped = []
    }

    required init() {
        buttonStyleNode = SKSpriteNode(id: .None)
        buttonBackgroundNode = SKSpriteNode(id: .None)

        super.init()

        buttonStyleNode.zPosition = zPosition - 0.1
        self << buttonStyleNode

        buttonBackgroundNode.zPosition = zPosition - 0.2
        self << buttonBackgroundNode

        let touchableComponent = TouchableComponent()
        touchableComponent.containsTouchTest = { [unowned self] (_, location) in
            return self.containsTouchTest(location)
        }
        touchableComponent.on(.Enter) { _ in
            self.highlight()
        }
        touchableComponent.on(.Exit) { _ in
            self.unhighlight()
        }
        touchableComponent.on(.UpInside) { _ in
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

    func containsTouchTest(location: CGPoint) -> Bool {
        let width = max(44, size.width)
        let height = max(44, size.height)

        var minX: CGFloat, maxX: CGFloat
        var minY = -height / 2
        var maxY = height / 2

        switch alignment {
        case .Left:
            minX = 0
            maxX = width
        case .Right:
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
        case .None:
            break
        case .RectToFit:
            let margin: CGFloat = 10
            size = CGSize(CGFloat(ceil(textSize.width)) + margin, CGFloat(ceil(textSize.height)) + margin)
            textureStyle = .RectSized(size.width, size.height)
        default:
            size = style.size
        }
        buttonStyleNode.textureId(.Button(style: textureStyle, color: border ?? color))

        var backgroundId: ImageIdentifier = .None
        if let background = background {
            switch style {
            case .None: break
            case .Circle, .CircleSized:
                backgroundId = .FillColorCircle(size: size, color: background)
            default:
                backgroundId = .FillColorBox(size: size, color: background)
            }
        }
        buttonBackgroundNode.textureId(backgroundId)

        switch alignment {
        case .Left:
            buttonStyleNode.anchorPoint = CGPoint(0, 0.5)
            buttonBackgroundNode.anchorPoint = CGPoint(0, 0.5)
        case .Right:
            buttonStyleNode.anchorPoint = CGPoint(1, 0.5)
            buttonBackgroundNode.anchorPoint = CGPoint(1, 0.5)
        default:
            buttonStyleNode.anchorPoint = CGPoint(0.5, 0.5)
            buttonBackgroundNode.anchorPoint = CGPoint(0.5, 0.5)
        }
    }

    func highlight() {
        prevZ = zPosition
        z = .Top
        super.setScale(preferredScale * 1.1)
    }

    func unhighlight() {
        zPosition = prevZ
        super.setScale(preferredScale)
    }

}
