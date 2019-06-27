////
/// ImageArtists.swift
//

extension ImageIdentifier {

    var artist: Artist {
        switch self {
        case .none:
            return Artist()
        case let .colorLine(length, color):
            let color = UIColor(hex: color)
            let artist = LineArtist(length, color)
            return artist
        case let .colorPath(path, color):
            let color = UIColor(hex: color)
            let artist = PathArtist(path, color)
            return artist
        case let .letter(letter, color):
            let artist = TextArtist()
            artist.text = letter
            artist.font = DefaultFont
            artist.color = UIColor(hex: color)

            return artist
        case let .button(style, borderColor):
            let artist = ButtonArtist()
            artist.borderColor = borderColor.map { UIColor(hex: $0) }
            switch style {
            case .squareSized, .rectSized:
                artist.style = .square
                artist.size = style.size
            case .circleSized:
                artist.style = .circle
                artist.size = style.size
            default:
                break
            }
            return artist
        case let .fillColorBox(size, color):
            let color = UIColor(hex: color)
            let artist = RectArtist(size, color)
            artist.drawingMode = .fill
            return artist
        case let .fillColorCircle(size, color):
            let color = UIColor(hex: color)
            let artist = CircleArtist(size, color)
            artist.drawingMode = .fill
            return artist
        case .expand:
            return ExpandArtist()
        }
    }

}
