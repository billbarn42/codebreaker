Feature: code-breaker submits a guess

If the codebreaker submits a correct guess in less than 7 turns, the game ends and a message is displayed congraulating the codebreaker on the win.

  Scenario: win game
    Given the secret code is "1234"
    When I guess "1234"
    And there have been less than 7 turns
    Then I should see "Congratulations, you won!"
    And I should see "The secret code was " "1234"

  Scenario: lose game
    Given the secret code is "1234"
    When there have been more than 7 turns
    Then I should see "Sorry, you lost!"
    And I should see "The secret code was " "1234"