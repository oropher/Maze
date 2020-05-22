import java.util.List;
import java.util.ArrayList;
import java.util.ArrayDeque;
import java.util.Deque;

int rows;
int cols;
int rowSize = 10;
int colSize = 10;
Cell cells[][];
List<Cell> neighborsList = new ArrayList();
Cell current;
Deque<Cell> stack = new ArrayDeque();

void setup(){
  size(501, 501);
  frameRate(5);
  rows = floor(height / rowSize);
  cols = floor(width / colSize);
  cells = new Cell[rows][cols];
  for(int i = 0; i<rows; i++){
    for(int j = 0; j<cols; j++){
      cells[i][j] = new Cell(i, j, rowSize, colSize);
      cells[i][j].show();
    }
  }
  frameRate(300);
  noLoop();
  current = cells[0][0];
  //evalCell(0, 0);
  current.visited = true;
  stack.push(current);
}

void keyPressed() {
  if (key == ENTER) {
    loop();
  }
}



void draw(){
  background(51);
  for(int i = 0; i<rows; i++){
    for(int j = 0; j<cols; j++){
      cells[i][j].show();
    }
  }
  if(stack.size() > 0){
    current = stack.pop();
    current.hightlight();
    if(hasUnvisitedNeighbors(current)){
      stack.push(current);
      Cell choosenCell = getUnvisitedNeighbor();
      neighborsList.clear();
      removeWalls(current, choosenCell);
      choosenCell.visited = true;
      stack.push(choosenCell);
    }
  }
}

void evalCell(int x, int y){
  //println("Comienza con: "+ x + ", " + y);
  Deque<Cell> stack = new ArrayDeque();
  cells[x][y].visited = true;
  stack.push(cells[x][y]);
  while(!stack.isEmpty()){
    Cell currentCell = stack.pop();
    currentCell.hightlight();
    delay(100);
    if(hasUnvisitedNeighbors(currentCell)){
      stack.push(currentCell);
      Cell choosenCell = getUnvisitedNeighbor();
      neighborsList.clear();
      removeWalls(currentCell, choosenCell);
      choosenCell.visited = true;
      choosenCell.show();
      stack.push(choosenCell);
    }
  }
}


public void removeWalls(Cell current, Cell choosen){
  int x = current.x - choosen.x;
  if(x == 1){
    current.walls[3] = false;
    choosen.walls[1] = false; 
  } else if(x==-1){
    current.walls[1] = false;
    choosen.walls[3] = false;
  }
  int y = current.y - choosen.y;
  if(y == 1){
    current.walls[0] = false;
    choosen.walls[2] = false; 
  } else if(y==-1){
    current.walls[2] = false;
    choosen.walls[0] = false;
  } 
}


public Cell getUnvisitedNeighbor(){
  int i = floor(random(0, neighborsList.size()));
  return neighborsList.get(i);
}


boolean hasUnvisitedNeighbors(Cell cell){
  int x = cell.x;
  int y = cell.y;
  Cell top = getCellAt(x, y-1);
  Cell right = getCellAt(x+1, y);
  Cell bottom = getCellAt(x, y+1);
  Cell left = getCellAt(x-1, y);
  if(top != null && !top.visited){
    neighborsList.add(top);
  }
  if(right!= null && !right.visited){
    neighborsList.add(right);
  }
  if(bottom!= null && !bottom.visited){
    neighborsList.add(bottom);
  }
  if(left!= null && !left.visited){
    neighborsList.add(left);
  }
  if(!neighborsList.isEmpty()){
    return true;
  }
  return false;
}

public Cell getCellAt(int x, int y){
  if(x<0 || y<0 || x>cols-1 || y>rows-1){
   return null;
  }
  return cells[x][y];
}

class Cell {
  
  int x;
  int y;
  int rowSize;
  int colSize;
  boolean visited = false;
  boolean[] walls = {true, true, true, true};
 
  public Cell(int x, int y, int rowSize, int colSize){
    this.x = x;
    this.y = y;
    this.rowSize = rowSize;
    this.colSize = colSize;
  }

  public void show(){
    int i = x*colSize;
    int j = y*rowSize;
    if(this.visited){
      noStroke();
      fill(50, 125, 168);
      rect(i, j, rowSize, colSize);
    }
    stroke(255);
    if(walls[0]){
      line(i, j, i+colSize, j);
    }
    if(walls[1]){
      line(i+colSize, j, i+colSize, j+rowSize);
    }
    if(walls[2]){
      line(i+colSize, j+rowSize, i, j+rowSize);
    }
    if(walls[3]){
      line(i, j+rowSize, i, j);
    }
  }
  
  public void hightlight(){
    int i = x*colSize;
    int j = y*rowSize;
    noStroke();
    fill(0, 0, 255, 100);
    rect(i, j, rowSize, colSize);
  }
  
  public String toString(){
    return "x,y: " + x +", " + y + " walls: " + walls[0] + ", " + walls[1] + ", " + walls[2] + ", " + walls[3];
  }
}
