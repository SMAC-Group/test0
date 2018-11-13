#' @title St-Petersburg paradox games
#'
#' @description The function returns a veector of net gains (money gained minus fee).
#'
#' @param n_games number of games to play
#' @param fee fee for playing one game
#' @param seed seed for the random generator (for reproducibility)
#'
#' @return a vector of gains
#' @author Samuel Orso
#' @export
#' @examples
#' st_petersburg_game(10,10,1)
st_petersburg_game <- function( # function that returns gains with class "sp_game"
  n_games,
  fee,
  seed){
  # st Petersburg game
  gains <- vector(mode = "double", length = n_games)

  set.seed(seed)

  for(i in 1:n_games){
    head <- TRUE
    bet <- 1
    while (head) {
      # toss a coin
      x <- rbinom(n = 1, size = 1, prob = 0.5)

      # verify the coin
      if(x == 0){
        head <- FALSE
      }

      # update the bet
      bet <- bet * 2
    }
    # save the result
    gains[i] <- bet - fee
  }


  class(gains) <- "sp_game"
  gains
}


plot.sp_game <- function(obj){ # defines the plot to return for "sp_game"
  mu <- round(mean(obj),2)
  h <- hist(obj, ylab = "number of games", xlab = "gains", col = "gray70", border = "white",
            cex.lab = 2, main = "Distribution of gains in St-Petersburg games", cex.main = 2, col.axis="gray30",
            nclass = max(10, min(length(obj)/10,50)), probability = F)
  text(x = (max(obj)+min(obj))/2, y = max(h$counts), labels = paste0("Average gain: ",mu), col = "red", cex = 2)
}
