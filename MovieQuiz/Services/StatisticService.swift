
import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage = UserDefaults.standard
    private enum Keys: String {
        case correct
        case total
        case gamesCount
        case bestGameCorrectAnswers
        case bestGameTotalQuestions
        case bestGameDate
    }
    
    var totalAccuracy: Double {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            guard total != 0 else { return 0 }
            return Double(correct) / Double(total) * 100.0
        }
    }
    
    var gamesCount: Int {
        get {
            return storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.bestGameCorrectAnswers.rawValue)
            let total = storage.integer(forKey: Keys.bestGameTotalQuestions.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrectAnswers.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotalQuestions.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let currentGame = GameResult(correct: count, total: amount, date: Date())
        
        if bestGame.correct < currentGame.correct {
            bestGame = currentGame
        }
        
        let correctAnswers = storage.integer(forKey: Keys.correct.rawValue) + count
        let totalAnswers = storage.integer(forKey: Keys.total.rawValue) + amount
        
        storage.set(correctAnswers, forKey: Keys.correct.rawValue)
        storage.set(totalAnswers, forKey: Keys.total.rawValue)
        gamesCount += 1
    }
}
