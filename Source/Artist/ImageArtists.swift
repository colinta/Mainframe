////
/// ImageArtists.swift
//

extension ImageIdentifier {

    var artist: Artist {
        switch self {
        case .None:
            return Artist()
        case let .ColorLine(length, color):
            let color = UIColor(hex: color)
            let artist = LineArtist(length, color)
            return artist
        case let .ColorPath(path, color):
            let color = UIColor(hex: color)
            let artist = PathArtist(path, color)
            return artist
        case let .Letter(letter, color):
            let artist = TextArtist()
            artist.text = letter
            artist.font = SmallFont
            artist.color = UIColor(hex: color)

            return artist
        case let .Button(style, color):
            let artist = ButtonArtist()
            artist.color = UIColor(hex: color)
            switch style {
            case .Square, .SquareSized, .RectSized:
                artist.style = .Square
                artist.size = style.size
            case .Circle, .CircleSized:
                artist.style = .Circle
                artist.size = style.size
            default:
                break
            }
            return artist
        case let .Dot(color):
            let artist = DotArtist()
            artist.color = UIColor(hex: color)
            return artist
        case let .FillColorBox(size, color):
            let color = UIColor(hex: color)
            let artist = RectArtist(size, color)
            artist.drawingMode = .fill
            return artist
        case let .FillColorCircle(size, color):
            let color = UIColor(hex: color)
            let artist = CircleArtist(size, color)
            artist.drawingMode = .fill
            return artist
        case .Expand:
            return ExpandArtist()
        }
    }

}
