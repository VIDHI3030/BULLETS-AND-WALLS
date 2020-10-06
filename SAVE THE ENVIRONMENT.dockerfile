//initiate Game STATEs
var PLAY = 1;
var END = 0;
var gameState = PLAY;

//create a plant sprite
var plant = createSprite(200,380,20,50);
plant.loadImage("plant.png");

//set collision radius for the plant
plant.setCollider("circle",0,0,30);

//scale and position the plant
plant.scale = 0.5;
plant.x = 50;

//create a ground sprite
var ground = createSprite(200,380,400,20);
ground.loadImage("ground2");
ground.x = ground.width /2;

//invisible Ground to support plant
var invisibleGround = createSprite(200,385,400,5);
invisibleGround.visible = false;

//create Obstacle and sun Groups
var pollutantGroup = createGroup();
var sunsGroup = createGroup();

//place gameOver and restart icon on the screen
var gameOver = createSprite(200,300);
var restart = createSprite(200,340);
gameOver.text("SAVE THE ENVIONMENT");
gameOver.scale = 0.5;
restart.text("restart");
restart.scale = 0.5;

gameOver.visible = false;
restart.visible = false;

//set text
textSize(18);
textFont("Georgia");
textStyle(BOLD);

//score
var count = 0;

function draw() {
  //set background to white
  background("white");
  //display score
  text("Score: "+ count, 250, 100);
  console.log(gameState);
  
  if(gameState === PLAY){
    //move the ground
    ground.velocityX = -(6 + 3*count/100);
    //scoring
    count += Math.round(World.frameRate/60);
    
    if (count>0 && count%100 === 0){
      playSound("checkPoint.mp3");
    }
    
    if (ground.x < 0){
      ground.x = ground.width/2;
    }
    
     //jump when the space key is pressed
    if(keyDown("space") && plant.y >= 359){
      plant.velocityY = -12 ;
      playSound("jump.mp3");
    }
  
    //add gravity
    plant.velocityY = plant.velocityY + 0.8;
    
    //spawn the suns
    spawnsuns();
  
    //spawn pollutant
    spawnpollutant();
    
    //End the game when plant is touching the obstacle
    if(pollutantGroup.isTouching(plant)){
      playSound("jump.mp3");
      gameState = END;
      playSound("die.mp3");
    }
  }
  
  else if(gameState === END) {
    gameOver.visible = true;
    restart.visible = true;
    
    //set velcity of each game object to 0
    ground.velocityX = 0;
    plant.velocityY = 0;
    pollutantGroup.setVelocityXEach(0);
    sunsGroup.setVelocityXEach(0);
    
    
    //set lifetime of the game objects so that they are never destroyed
    pollutantGroup.setLifetimeEach(-1);
    sunsGroup.setLifetimeEach(-1);
    
    
  }
  
  if(mousePressedOver(restart)) {
    reset();
  }
  
  //console.log(plant.y);
  
  //stop plant from falling down
  plant.collide(invisibleGround);
  
  drawSprites();
}

function reset(){
  gameState=PLAY;
  gameOver.visible=false;
  restart.visible=false;
  pollutantGroup.destroyEach();
  sunsGroup.destroyEach();
  plant.loadImage("plant");
  count=0;
}

function spawnpollutant() {
  if(World.frameCount % 60 === 0) {
    var obstacle = createSprite(400,365,10,40);
    obstacle.velocityX = - (6 + 3*count/100);
    
    //generate random pollutant
    var rand = randomNumber(1,6);
    obstacle.loadImage("pollutant1.png" && "pollutant2.png", "pollutant3.png");
    
    //assign scale and lifetime to the obstacle           
    obstacle.scale = 0.5;
    obstacle.lifetime = 70;
    //add each obstacle to the group
    pollutantGroup.add(obstacle);
  }
}

function spawnsuns() {
  //write code here to spawn the suns
  if (World.frameCount % 60 === 0) {
    var sun = createSprite(400,320,40,10);
    sun.y = randomNumber(280,320);
    sun.loadImage("sun");
    sun.scale = 0.5;
    sun.velocityX = -3;
    
     //assign lifetime to the variable
    sun.lifetime = 134;
    
    //adjust the depth
    sun.depth = plant.depth;
    plant.depth = plant.depth + 1;
    
    //add each sun to the group
    sunsGroup.add(sun);
  }
  
}
