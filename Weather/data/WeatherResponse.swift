import Foundation

struct WeatherResponse: Decodable, Equatable {
    
	let coord: Coord?
	let weather: [Weather]?
	let base: String?
	let main: Main?
    let visibility: Int?
	let wind: Wind?
	let clouds: Clouds?
	let dt: Int?
	let sys: Sys?
    let timezone: Int?
	let id: Int?
	let name: String?
	let cod: Int?
    var uuid: String?
    var favoriteLocation: FavoriteLocationEntity?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
    }
    
    init (resultModel: WeatherResponse) {
        self.coord = resultModel.coord
        self.weather = resultModel.weather
        self.base = resultModel.base
        self.main = resultModel.main
        self.visibility = resultModel.visibility
        self.wind = resultModel.wind
        self.clouds = resultModel.clouds
        self.dt = resultModel.dt
        self.sys = resultModel.sys
        self.timezone = resultModel.timezone
        self.id = resultModel.id
        self.name = resultModel.name
        self.cod = resultModel.cod
        self.uuid = resultModel.uuid
        self.favoriteLocation = resultModel.favoriteLocation
    }
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.uuid == rhs.uuid
    }

}
