var bullet,wall;
var speed,weight,thickness;
function setup() {
  createCanvas(1400,400);
  speed=random(223,321);
  weight=random(30,52);
  thickness=random(22,83);
 bullet= createSprite(50, 200, 50, 5);
 wall= createSprite(1300,200,thickness,200);
 bullet.shapeColor="gold";
 wall.shapeColor="black";
 bullet.velocityX= speed;
 
}

function draw() {
  background(255,255,255); 
  if (wall.x-bullet.x<bullet.width/2+wall.width/2    ){
    bullet.velocityX=0;
    var damage= 0.5*weight*speed*speed/(thickness*thickness*thickness);
    if(damage>=10){
      wall.shapeColor="red";

    } 
    if(damage<10){
      wall.shapeColor="green";
      
    }
   
    }

  drawSprites();

}