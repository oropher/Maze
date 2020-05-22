import java.util.ArrayDeque;

int rows = 20;
int cols = 20;
int rowSize;
int colSize;
Cell cells[][];

void setup(){
  size(501, 501);
  rowSize = floor(height / rows);
  colSize = floor(width / cols);
  cells = new Cell[rowSize][colSize];
  for(int i = 0; i<rowSize; i++){
    for(int j = 0; j<colSize; j++){
      cells[i][j] = new Cell(i*rowSize, j*colSize, rowSize, colSize);
    }
  }
}



void draw(){
  background(51);
  for(int i = 0; i<rowSize; i++){
    for(int j = 0; j<colSize; j++){
      cells[i][j].show();
    }
  }
}

void evalCell(int x, int y){
  Deque<Cell> stack = new ArrayDeque<>();
  cells[x][y].visited = true;
  stack.push(cells[x][y]);
  while(!stack.isEmpty()){
    Cell currentCell = stack.pop();
    if(hasUnvisitedNeighbours(currentCell)){
      stack.push(currentCell);
      boolean wasVisited = false;
      Cell choosenCell = null;
      while(!wasVisited){
        int xtemp = int(random(currentCell.x-1, currentCell.x+1));
        int ytemp = int(random(currentCell.y-1, currentCell.y+1));
        if((xtemp != currentCell.x && ytemp != currentCell.y) && xtemp >= 0 && xtemp < rowSize && ytemp >= 0 && xtemp < colSize){
          if(!cells[xtemp][ytemp].visited){
            choosenCell = cells[xtem][ytemp];
          }
        }
      }
    }
  }
}

boolean hasUnvisitedNeighbours(Cell cell){
  int x = cell.x;
  int y = cell.y;
  for(int i=x-1; i<=x+1; i++){
    for(int j=y-1; j<=y+1; j++){
      if(i>=0 && i<rowSize && j>=0 && j<colSize){
        if(cells[i][j].visited){
          return true;
        }
      }
    }
  }
  return false;
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
    stroke(255);
    if(walls[0]){
      line(x, y, x+colSize, y);
    }
    if(walls[1]){
      line(x+colSize, y, x+colSize, y+rowSize);
    }
    if(walls[2]){
      line(x+colSize, y+rowSize, x, y+rowSize);
    }
    if(walls[3]){
      line(x, y+rowSize, x, y);
    }
  }
}










































