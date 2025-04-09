import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage = UserDefaults.standard
    
    var totalAccuracy: Double {
        get {
            let correct = storage.integer(forKey: StatisticKeys.correct.rawValue)
            let total = storage.integer(forKey: StatisticKeys.total.rawValue)
            guard total != 0 else { return 0 }
            
            return Double(correct) / Double(total) * 100.0
        }
    }
    
    var gamesCount: Int {
        get {
            return storage.integer(forKey: StatisticKeys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: StatisticKeys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: StatisticKeys.bestGameCorrectAnswers.rawValue)
            let total = storage.integer(forKey: StatisticKeys.bestGameTotalQuestions.rawValue)
            let date = storage.object(forKey: StatisticKeys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: StatisticKeys.bestGameCorrectAnswers.rawValue)
            storage.set(newValue.total, forKey: StatisticKeys.bestGameTotalQuestions.rawValue)
            storage.set(newValue.date, forKey: StatisticKeys.bestGameDate.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let currentGame = GameResult(correct: count, total: amount, date: Date())
        
        if bestGame.correct < currentGame.correct {
            bestGame = currentGame
        }
        
        let correctAnswers = storage.integer(forKey: StatisticKeys.correct.rawValue) + count
        let totalAnswers = storage.integer(forKey: StatisticKeys.total.rawValue) + amount
        
        storage.set(correctAnswers, forKey: StatisticKeys.correct.rawValue)
        storage.set(totalAnswers, forKey: StatisticKeys.total.rawValue)
        gamesCount += 1
    }
}
