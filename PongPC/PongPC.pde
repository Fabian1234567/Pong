color white = color(255, 255, 255);
color black = color(0, 0, 0);
color green = color(0, 200, 0);

color screenC = black;
color paddleC = white;
color playerC = white;
color ballC = white;
color textC = green;

int sizeX = 500;
int sizeY = 500;

int ballX = sizeX / 2; 
int ballY = sizeY / 2;
int ballSize = 10;

int speedX = -2;
int speedY = 3;

int paddleHeight = 50;
int paddleWidth = 15;

int playerOneX = 5;
int playerOneY = sizeY / 2 - paddleHeight / 2;

int playerTwoX = sizeX - 5 - paddleWidth;
int playerTwoY = sizeY / 2 - paddleHeight / 2;

int playerOneScore = 0;
int playerTwoScore = 0;

int playerOneDirection = 0; // direction: -1 up, 0 stop, 1 down
int playerTwoDirection = 0; // direction: -1 up, 0 stop, 1 down

boolean ballOut = false; // true if the ball it out

int maxScore = 9; // score to win the game

int gameMode = 1; // 0 = game over, 1 = intro, 2 - init game, 3 = in game, 4 = pause, 5 = end game, 6 = enter highscore, 7 = finalize, 8-9 = not used 

void setup()
{
  size(500, 500);
  textSize(36);
}

void draw()
{
  switch (gameMode)
  {
    case 1: // intro
      // put the paddles back to start
      playerOneY = sizeY / 2 - paddleHeight / 2;
      playerTwoY = sizeY / 2 - paddleHeight / 2;
      // nothing special to do here, could add a text like Game Over, or some intro animation (self-play)
    break;  

    case 2: //init
      ballX = sizeX / 2; 
      ballY = sizeY / 2;
      playerOneScore = 0;
      playerTwoScore = 0;
      ballOut = false;
      gameMode = 3;  // switch to inGame mode
    break;  

    case 3: // inGame - we do all active gaming stuff here
      if (playerOneDirection == -1) // up
      {
        if (playerOneY > 0)
        {
          playerOneY = playerOneY - 5;
        }
      }
    
      if (playerOneDirection == 1) // down
      {
        if (playerOneY + paddleHeight < sizeY)
        {
          playerOneY = playerOneY + 5;
        }
      }
    
      if (playerTwoDirection == -1) // up
      {
        if (playerTwoY > 0)
        {
          playerTwoY = playerTwoY - 5;
        }
      }
    
      if (playerTwoDirection == 1) // down
      {
        if (playerTwoY + paddleHeight < sizeY)
        {
          playerTwoY = playerTwoY + 5;
        }
      }
    
    
      // add speed to ball position
      ballX = ballX + speedX;
      ballY = ballY + speedY;
    
      // check of we hit the bottom or hit the top, then reverse direction
      if ( (ballY > height - ballSize) || (ballY < 0 + ballSize) )
      {
        speedY = speedY * -1;
      }
    
    
      // see if we drop behind player one's paddle
      if (ballX < playerOneX + paddleWidth + ballSize)
      {
        if ( (ballY < playerOneY -10) || (ballY > playerOneY + paddleHeight +10) ) // did we miss player one's paddle ?
        {
          ballOut = true; // yes - ball is out in any case
          if (ballX < 0) // continue running until we reach the border
          {
            playerTwoScore++;
            ballX = sizeX / 2;
            ballY = sizeY / 2;
            // revert direction, to go against the other player
            speedX = speedX * -1;
            ballOut = false;
          }
        }
        else
        {
          if (ballOut == false) // is the ball still in the game ?
          {
            // we hit the paddle - revert direction = bounce
            speedX = speedX * -1;
          }
        }
      }
    
    
      // see if we drop behind player two's paddle
      if (ballX > playerTwoX - ballSize)
      {
        if ( (ballY < playerTwoY -10) || (ballY > playerTwoY + paddleHeight +10) ) // did we miss player two's paddle ?
        {
          ballOut = true; // yes - ball is out in any case
          if (ballX > sizeX) // continue running until we reach the border
          {
            playerOneScore++;
            ballX = sizeX / 2;
            ballY = sizeY / 2;
            // revert direction, to go against the other player
            speedX = speedX * -1;
            ballOut = false;
          }
        }
        else
        {
          if (ballOut == false) // is the ball still in the game ?
          {
            // we hit the paddle - revert direction = bounce
            speedX = speedX * -1;
          }
        }
      }
      
      if (playerOneScore >= maxScore || playerTwoScore >= maxScore) // end teh game if any player hit the max score
      {
        gameMode = 1;
      } 
    break;  

    case 4: //pause
      // do nothing, this will stop the motion
    break;  

  }


  // always draw the items on the screen
  background(screenC); // erase screen

  // show the paddles on screen
  stroke(paddleC);
  fill(paddleC);
  rect(playerOneX, playerOneY, paddleWidth, paddleHeight);
  rect(playerTwoX, playerTwoY, paddleWidth, paddleHeight);

  // draw the ball at the desired position
  stroke(ballC);
  fill(ballC);
  ellipse(ballX, ballY, ballSize, ballSize);
 
  // display the scores
  fill(textC);
  text(playerOneScore, 100, 50); 
  text(playerTwoScore, sizeX - 100, 50);  
}


void keyPressed(KeyEvent e)
{
  if (key == 's')
  {
    playerOneDirection = -1;
  }
  else if (key == 'x')
  {
    playerOneDirection = 1;
  }
  else if (key == 'j')
  {
    playerTwoDirection = -1;
  }
  else if (key == 'n')
  {
    playerTwoDirection = 1;
  }

  else if (key == ' ')
  {
    if (gameMode == 1)
    {
      gameMode = 2;
    }
  }
  else if (key == 'p')
  {
    if (gameMode == 3)
    {
      gameMode = 4;
    }
    else if (gameMode == 4)
    {
      gameMode = 3;
    }
  }
}

void keyReleased(KeyEvent e)
{
  if (key == 's')
  {
    playerOneDirection = 0;
  }
  else if (key == 'x')
  {
    playerOneDirection = 0;
  }
  else if (key == 'j')
  {
    playerTwoDirection = 0;
  }
  else if (key == 'n')
  {
    playerTwoDirection = 0;
  }
}
